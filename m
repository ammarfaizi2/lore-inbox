Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTKQIVY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 03:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbTKQIVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 03:21:24 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:7814 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S263369AbTKQIVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 03:21:22 -0500
Date: Mon, 17 Nov 2003 08:21:34 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@einstein.homenet
To: viro@parcelfarce.linux.theplanet.co.uk
cc: linux-kernel@vger.kernel.org
Subject: Re: seq_file and exporting dynamically allocated data
In-Reply-To: <20031117054820.GT24159@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0311170745170.1089-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > a) no "THIS_MODULE" style module refcounting, so I had to do manual 
> > MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT in ->open/release. I am aware of the 
> > deficiencies of this approach, of course (it's been discussed too many 
> > times in the last several years).
> 
> 	You don't need to do that.  Look, these ->open() and ->release()
> are not some new methods - they are ->open() and ->release() of your
> struct file.  The fact that they happen to call functions from seq_file.c
> doesn't change anything - they are struct file methods, sitting in some
> instance of struct file_operations.  And just as with any such instance,
> you have ->owner in struct file_operations.  Which will be honoured by
> open(2) - just as with any other file.

Thank you. Yes, I have now changed my code to do what you suggest and 
it works fine.

> > b) no way to reset the 'offset' to 0 when the ->next() detects that it is
> > back at the head of linked list, i.e. when it should return NULL. It's OK
> 
> Let me get it straight - you want an infinite file, with no EOF anywhere
> and contents more or less repeating itself?  _And_ you want a working
> lseek() on that?

I only need lseek to offset 0 and it does work when called from userspace
as lseek(fd, 0, SEEK_SET). But what I wanted is "auto-rewinding read()".
So, when the driver detects that we reached EOF (i.e. hit 'init_task' in
->next()) it should somehow cause the offset to be reset to 0 but return
the read(2) to user as normal. I didn't figure out how to do this. The 
intuitive solution *ppos = 0 in ->next() didn't work.

On the other hand, some more thought suggests that even if such
"auto-rewinding read" existed, perhaps it wouldn't help after all.  
Because, the user app is doing the following to get information about all
processes efficiently:

first_loop = 1

while(1) {

    read as much as can fit in a page (i.e. single read(2) syscall)

    if !first_loop and the first element of the page (it can only be 
                  first) is 'swapper' 
    then
         lseek(fd, 0, SEEK_SET);
         break;         
    fi

    if (first_loop)
        first_loop = 0;
}

So, we read an extra page in vain on each iteration. But this is OK as
performance is not an issue (my module is already 26 times faster than a
highly optimized NT implementation).

Now, since there is no way to detect EOF, other than by reading an extra 
page and discovering that it belongs to the next iteration, we have to do 
the lseek(fd, 0, SEEK_SET) anyway.

So, the "auto-rewinding" read would only help the cases where application 
doesn't need to differentiate between samples and is happy to just 
continuously read chunks packed into pages one by one as fast as 
possible. In this case it doesn't need to lseek to 0, so auto-rewinding on 
kernel side would prevent it from slowing down.

Kind regards
Tigran


