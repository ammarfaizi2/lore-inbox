Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVCVVmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVCVVmx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 16:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVCVVmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 16:42:53 -0500
Received: from alog0193.analogic.com ([208.224.220.208]:9122 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262062AbVCVVmH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 16:42:07 -0500
Date: Tue, 22 Mar 2005 16:39:32 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: lseek on /proc/kmsg
In-Reply-To: <Pine.LNX.4.61.0503222215310.19826@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0503221633230.7421@chaos.analogic.com>
References: <Pine.LNX.4.61.0503221320090.5551@chaos.analogic.com>
 <Pine.LNX.4.61.0503222020470.32461@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0503221423560.6369@chaos.analogic.com>
 <Pine.LNX.4.61.0503222215310.19826@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005, Jan Engelhardt wrote:

>> Gawd, you are a hacker. I already have to suck on pipes
>> because I can't seek them. Now, I can't even seek a
>> file-system???!!
>
> Here goodie goodie...
>
> diff -pdru linux-2.6.11.4/fs/proc/kmsg.c linux-2.6.11-AS9/fs/proc/kmsg.c
> --- linux-2.6.11.4/fs/proc/kmsg.c       2005-03-21 20:14:58.000000000 +0100
> +++ linux-2.6.11-AS9/fs/proc/kmsg.c     2005-03-22 21:28:40.000000000 +0100
> @@ -46,10 +46,15 @@ static unsigned int kmsg_poll(struct fil
>        return 0;
> }
>
> +static loff_t kmsg_seek(struct file *filp, loff_t offset, int origin) {
> +    if(origin != 2 /* SEEK_END */ || offset < 0) { return -ESPIPE; }
> +    return do_syslog(5, NULL, 0);
> +}
>
> struct file_operations proc_kmsg_operations = {
>        .read           = kmsg_read,
>        .poll           = kmsg_poll,
>        .open           = kmsg_open,
>        .release        = kmsg_release,
> +        .llseek         = kmsg_seek,
> };
>
>
> Works so far that do_syslog is called with the correct parameters --
> however, that does not work. (Did I discover a bug?)
>
> # rcsyslog stop;  # so that kmsg is not slurped by someone else
> # perl -le 'open X,"</proc/kmsg";seek X,0,2;print read X,$b,3'
>
> the perl command should block, because with the seek(), we've just emptied the
> syslog ring buffer. Obviously, it does not, and read() succeeds - prints 3.
> Any hints on what's wrong here?
>

Sure, read() needs to be modified to respect the file-position
set by kmsg_seek(). I don't think you can get away with the
call back into do_syslog.

In other words we shouldn't move a user-mode hack into the
kernel.

>
> Jan Engelhardt
> -- 
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
