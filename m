Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273255AbRJCLzP>; Wed, 3 Oct 2001 07:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273822AbRJCLzF>; Wed, 3 Oct 2001 07:55:05 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:60860 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S273255AbRJCLyz>; Wed, 3 Oct 2001 07:54:55 -0400
Message-ID: <3BBAFB65.6070802@antefacto.com>
Date: Wed, 03 Oct 2001 12:49:57 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alex Larsson <alexl@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Directory notification problem
In-Reply-To: <Pine.LNX.4.33.0110022206100.29931-100000@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think if you want better than 1s resolution you need to
handle it in user space. I've done this using 2 methods
outlined below. This first may be more responsive for
your app, though depending on the processing you have
to do on each file it may be too great an overhead to
process things twice, and if you want to process the data
multiple times within a second then you're screwed (you
probably don't want to do this from what I understand?).

A generation counter like you suggest would be very nice though!

Padraig.

/////////////////////////////////////////////////
// Delayed processing method
/////////////////////////////////////////////////
struct file_data
{
    char* name;
    time_t last_mtime;
    long generation_count; //wouldn't this be nice ;-)
}

bool filechanged(const file_data* file)
{
    struct stat stat_st;
    bool modified = false;

    if (!stat(file->name, &stat_st)) {
        if (stat_st.st_mtime != file->last_mtime) {
            modified = true;
            file->last_mtime = stat_st.st_mtime;
            sleep(1); //make sure any new updates in this mtime processed.
        }
    }
    return modified;
}
/////////////////////////////////////////////////
// Double check method
/////////////////////////////////////////////////
struct file_data
{
    char* name;
    time_t last_mtime;
    bool secondRun = false;
    long generation_count; //wouldn't this be nice ;-)
}

bool filechanged(const file_data* file)
{
    struct stat stat_st;
    bool modified = false;

    if (!stat(file->name, &stat_st)) {
        if ((stat_st.st_mtime != file->last_mtime) || (file->secondRun 
== true)) {
            modified = true;
            /* make sure don't miss data for this mtime (1 second 
resolution).
               Will do redundant check if no data written between now 
and next check
               but at least no new data will go unnoticed. Note this 
function must be called
               at a resolution >= 1 second for this to work. */

            if (file->last_mtime != stat_st.st_mtime) {
                    file->last_mtime = stat_st.st_mtime;
                    file->secondRun = true; //reset
            } else {
                    file->secondRun = false;
            }
        }
    }
    return modified;
}

Alex Larsson wrote:

>I discovered a problem with the dnotify API while fixing a FAM bug today.
>
>The problem occurs when you want to watch a file in a directory, and that 
>file is changed several times in the same second. When I get the directory 
>notify signal on the directory I need to stat the file to see if the 
>change was actually in the file. If the file already changed in the 
>current second the stat() result will be identical to the previous stat() 
>call, since the resolution of mtime and ctime is one second. 
>
>This leads to missed notifications, leaving clients (such as Nautilus or 
>Konqueror) displaying an state not representing the current state.
>
>The only userspace solutions I see is to delay all change notifications to 
>the end of the second, so that clients always read the correct state. This 
>is somewhat countrary to the idea of FAM though, as it does not give 
>instant feedback.
>
>Is there any possibility of extending struct stat with a generation 
>counter? Or is there another solution to this problem?
>
>/ Alex
>
>Please CC any reply to me, i'm not on the list.
>



