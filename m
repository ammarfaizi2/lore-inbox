Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbTARPbn>; Sat, 18 Jan 2003 10:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264856AbTARPbn>; Sat, 18 Jan 2003 10:31:43 -0500
Received: from mail.cs.umn.edu ([128.101.32.202]:13484 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id <S264853AbTARPbm>;
	Sat, 18 Jan 2003 10:31:42 -0500
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, alsa-devel@alsa-project.org,
       perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Patch?: linux-2.5.59/sound/soundcore.c referenced non-existant
 errno variable
From: Raja R Harinath <harinath@cs.umn.edu>
Date: Sat, 18 Jan 2003 09:40:36 -0600
In-Reply-To: <20030118031319.GA19982@vana.vc.cvut.cz> (Petr Vandrovec's
 message of "Sat, 18 Jan 2003 04:13:19 +0100")
Message-ID: <d9bs2e8o0b.fsf@bose.cs.umn.edu>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.3.50
 (i686-pc-linux-gnu)
References: <20030117155717.A6250@baldur.yggdrasil.com>
	<d9n0lz18an.fsf@bose.cs.umn.edu>
	<20030118031319.GA19982@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Petr Vandrovec <vandrove@vc.cvut.cz> writes:

> On Fri, Jan 17, 2003 at 08:49:36PM -0600, Raja R Harinath wrote:
>> Hi,
>> 
>> "Adam J. Richter" <adam@yggdrasil.com> writes:
>> 
>> > 	linux-2.5.59/sound/sound_firmware.c attempts to use the
>> > user level system call interface from the kernel, which I understand
>> > works on i386 and perhaps all architectures, but requires a variable
>> > named "errno." 
>> 
>> Which is provided in-kernel (not for modules) by 'lib/errno.c'.
>
> Not safe. We should either remove errno from kernel syscall wrappers 
> completely when building __KERNEL__ (just return -1 and nothing more
> specific), or even disallow use of unistd.h wrappers from kernel 
> completely (which is best solution IMHO). 

__KERNEL_SYSCALLS__ appears to be defined in several files.  Don't
know if they actually use any of them.

> BTW, static int errno is by far best solution if you do not agree with
> patch below: due to toolchain behavior soundcore will use its own
> errno for syscall wrappers it uses, and it is nearest to the behavior
> we wanted...
[snip]
>  static int do_mod_firmware_load(const char *fn, char **fp)
>  {
> -	int fd;
> +	struct file* filp;
>  	long l;
>  	char *dp;
> +	loff_t pos;
>
> -	fd = open(fn, 0, 0);
> -	if (fd == -1)
> +	filp = filp_open(fn, 0, 0);
> +	if (IS_ERR(filp))
>  	{
>  		printk(KERN_INFO "Unable to load '%s'.\n", fn);
>  		return 0;
>  	}
[snip]

I noticed that do_mod_firmware_load is wrapped by a
set_fs(get_gs())/set_fs(fs) pair in mod_firmware_load, presumably
because it performs an 'int 0x80' kernel syscall in there.  The
cleanup to use the VFS directly should probably kill the wrapper too.

- Hari
-- 
Raja R Harinath ------------------------------ harinath@cs.umn.edu
