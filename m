Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVCPDSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVCPDSY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 22:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbVCPDSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 22:18:24 -0500
Received: from sta.galis.org ([66.250.170.210]:54925 "HELO sta.galis.org")
	by vger.kernel.org with SMTP id S262484AbVCPDSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 22:18:15 -0500
From: "George Georgalis" <george@galis.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
  supervision@list.skarnet.org
Date: Tue, 15 Mar 2005 22:18:14 -0500
To: supervision@list.skarnet.org
Cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: a problem with linux 2.6.11 and sa
Message-ID: <20050316031814.GB1315@ixeon.local>
References: <20050303214023.GD1251@ixeon.local> <6.2.1.2.0.20050303165334.038f32a0@192.168.50.2> <20050303224616.GA1428@ixeon.local> <871xaqb6o0.fsf@amaterasu.srvr.nix> <20050308165814.GA1936@ixeon.local> <871xap9dfg.fsf@amaterasu.srvr.nix> <20050309152958.GB4042@ixeon.local> <m3is40z9dy.fsf@multivac.cwru.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3is40z9dy.fsf@multivac.cwru.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 06:28:35PM -0500, Paul Jarc wrote:
>"George Georgalis" <george@galis.org> wrote:
>> It (Gerrit Pape's technique) very defiantly stopped working a few revs
>> back (2.6.7?). I'm seeing a similar failed read from /dev/rtc and
>> mplayer with 2.6.10, now too.
>
>The /proc/kmsg problem happens because the kernel now checks for
>permission at read() instead of open().  The /dev/rtc problem seems to
>be a different beast.

Thanks for the kmsg clairfication, Paul.

>> while read file; do mplayer $file ; done <mediafiles.txt
>>
>> Failed to open /dev/rtc: Permission denied
>>
>> for file in `cat mediafiles.txt`; do mplayer $file ; done
>>
>> works.
>
>To simplify, what about these two:
>mplayer foo.mpg
>mplayer foo.mpg < mediafiles.txt
>
>You might try strace'ing both cases and see how they compare.

The particular host does not have X support so mpg is out.
I'm not sure that that test would work as mplayer requires filenames
as command arguments not stdin (exclusivly, I think); my guess
is mplayer would try to decode stdin.

this works fine
mplayer `cat zz.mtest `

Then I tried
mplayer /dev/stdin <zz.mtest

I got
Failed to open /dev/rtc: Permission denied (it should be readable by the user.)

so what the heck, I changed it...
$ ls -l /dev/rtc 
crw-rw----    1 root     root      10, 135 Mar 14  2002 /dev/rtc
chmod o+r /dev/rtc

Then I tried
while read file; do mplayer "$file" ; done <zz.mtest

and got
Linux RTC init error in ioctl (rtc_irqp_set 1024): Permission denied
Try adding "echo 1024 > /proc/sys/dev/rtc/max-user-freq" to your system startup 
scripts.

the file almost played though...
Playing /usr/nfs/sandbox/media/audio/_the-party-has-just-begun/Lebanese_Blonde.ogg.
Ogg file format detected.
...

But it seemed to take keyboard commands from the binary
No bind found for key _                                                         
A:   0.1 (00.1) ??,?%                                                           
No bind found for key R                         
A:   0.8 (00.8)  4.2%                                                           

and quit.  I tried the sysctl suggestion, no change, whenever a file list
is redirected to stdin, and a filename argument is given to mplayer, eg

while read file; do mplayer "$file" ; done <zz.mtest

now I don't have rtc errors but mplayer is getting strange input it
doesn't grok.

Once again, this works fine without the changed rtc perms or the sysctl
echo:

mplayer `cat zz.mtest`

I've not had a chance to properly test - I still think there is a new
kernel bug/feature but cant find time to properly track it down.

// George


-- 
George Georgalis, systems architect, administrator Linux BSD IXOYE
http://galis.org/george/ cell:646-331-2027 mailto:george@galis.org
