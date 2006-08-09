Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbWHIAKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbWHIAKx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 20:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWHIAKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 20:10:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:50744 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030361AbWHIAKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 20:10:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BwwI0jK8THdZjr2tLpFrGfw0S9GeNMX2qGEB1tGq2O33njf8jokkC0zHhA5UOkMM3/UME5v0G5B8iKj55PVMIG3owVJB245zr865fK7KjGo9nQq3V6Zq/5oFwbsLzl+NEyuD9z5i4Sd0lTgGCCu6Z3e2SH1wuc8XO42XGYX0VtQ=
Message-ID: <a762e240608081710h532f6bbl7a1670537fd481bd@mail.gmail.com>
Date: Tue, 8 Aug 2006 17:10:33 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.18-rc3-mm2 early_param mem= fix
Cc: "Hugh Dickins" <hugh@veritas.com>, "Andrew Morton" <akpm@osdl.org>,
       "Rusty Russell" <rusty@rustcorp.com.au>, "Andi Kleen" <ak@suse.de>,
       linux-kernel@vger.kernel.org, apw@shadowen.org
In-Reply-To: <m13bc8b6ca.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0608061811030.19637@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0608061829430.20012@blonde.wat.veritas.com>
	 <m13bc8b6ca.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Hugh Dickins <hugh@veritas.com> writes:
>
> > On Sun, 6 Aug 2006, Hugh Dickins wrote:
> >> I was impressed by how fast 2.6.18-rc3-mm2 is under memory pressure,
> >> until I noticed that my "mem=512M" boot option was doing nothing.  The
> >> two fixes below got it working, but I wonder how many other early_param
> >> "option=" args are wrong (e.g. "memmap=" in the same file): x86_64
> >> shows many such, i386 shows only one, I've not followed it up further.
> >
> > Oh, and that's not enough for it to show up in x86_64's /proc/cmdline.
>
> The /proc/cmdline part is easy.
>
> Someone deleted the copy from saved_command_line to command_line.
> Since kernel/params.c:parse_args called in init/main.c is destructive
> if we don't do this we will never see a reasonable command line in /proc,
> and /init implementations that parse /proc/command_line will choke horribly.
>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
> index 3bc1ff4..37206a4 100644
> --- a/arch/x86_64/kernel/setup.c
> +++ b/arch/x86_64/kernel/setup.c
> @@ -378,7 +378,8 @@ #endif
>         early_identify_cpu(&boot_cpu_data);
>
>         parse_early_param();
> -       *cmdline_p = saved_command_line;
> +       memcpy(command_line, saved_command_line, COMMAND_LINE_SIZE);
> +       *cmdline_p = command_line;
>
>         finish_e820_parsing();

Ok this helped keep the cmdline around but the early_param is still
busted with 2.6.18-rc3-mm2 (I don't have cmdline problem with non -mm
2.6.18-rc3).

I am booting with numa=hotadd=100 on x86_64.  The parameter
hotadd_percent is not getting setup right. Printk tells me that
numa_setup is not called during boot.

if I change

early_param("numa=", numa_setup);
to
early_param("numa", numa_setup);

The parameter hotadd_percent is setup right but there is a
"Malformed early option 'numa'" message.

Is there some other patch that I missed to fix this?

Also it seems like the earlyconsole isn't getting setup right.... It
seems to take forever to start (say about 20-30 seconds) This pause in
the boot is caused by the reserve hot-add patch but early console
should start before the pause.

command line is root=/dev/sda3
ip=9.47.66.153:9.47.66.169:9.47.66.1:255.255.255.0 resume=/dev/sda2
showopts earlyprintk=ttyS0,115200 console=ttyS0,115200 console=tty0
debug numa=hotadd=100

Again thing work as expected with 2.6.18-rc3.

Thanks,
  Keith
