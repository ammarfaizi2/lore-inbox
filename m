Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264952AbRGADAm>; Sat, 30 Jun 2001 23:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264953AbRGADAc>; Sat, 30 Jun 2001 23:00:32 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:34578 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S264952AbRGADAU>;
	Sat, 30 Jun 2001 23:00:20 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Riley Williams <rhw@MemAlpha.CX>
cc: Russell King <rmk@arm.linux.org.uk>, Adam J Richter <adam@yggdrasil.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6p6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs 
In-Reply-To: Your message of "Sat, 30 Jun 2001 21:36:26 +0100."
             <Pine.LNX.4.33.0106302120560.14977-100000@infradead.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 Jul 2001 13:00:13 +1000
Message-ID: <6794.993956413@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2001 21:36:26 +0100 (BST), 
Riley Williams <rhw@MemAlpha.CX> wrote:
> 1. Adam's point is that there are dep_* statements in the config
>    setup that have been used to say that a particular option is
>    dependant upon a particular architecture, but this doesn't work.
>
> 3. MY understanding of the situation is that ALL architecture
>    specific config lines are EXPECTED to be in the arch/*/config.in
>    files, where they will only even be seen when the relevant
>    architecture is being compiled for.
>
>As a result of this, I would summarise this discussion as saying that
>there is a bug in the kernel config scripts in that some options that
>should be located in the architecture-specific config files are in the
>all-architecture config files instead.

(1) and (3) are correct but your conclusion is not.  The problem is

  dep_tristate CONFIG_some_driver $CONFIG_some_arch

where the intention is to allow the driver only if some_arch is set.
When you compile for some_other_arch, CONFIG_some_arch is undefined.
dep_tristate treats undefined variables as "don't care" and we cannot
fix that without changing bash or a major rewrite of the shell scripts.
There are two solutions, either change all such lines to

  if [ "$CONFIG_some_arch" = "y" ];then
    tristate CONFIG_some_driver
  fi

or

  define_bool CONFIG_some_arch n

for all architectures at the start, followed by turning on the one that
is required.

Lots of if statements are messy and they will not prevent somebody
adding new options with exactly the same problem.  Explicitly setting
all but one arch variable to 'n' results in cleaner config scripts and
new arch dependent driver settings will automatically work.

