Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312871AbSDFXA6>; Sat, 6 Apr 2002 18:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312872AbSDFXA5>; Sat, 6 Apr 2002 18:00:57 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:41993 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312871AbSDFXA4>;
	Sat, 6 Apr 2002 18:00:56 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.19-pre6 standardize {aic7xxx,aicasm}/Makefile 
In-Reply-To: Your message of "Sat, 06 Apr 2002 12:58:07 MST."
             <200204061958.g36Jw7987298@aslan.scsiguy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 07 Apr 2002 09:00:44 +1000
Message-ID: <25618.1018134044@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Apr 2002 12:58:07 -0700, 
"Justin T. Gibbs" <gibbs@scsiguy.com> wrote:
>>Standardize the makefiles for aic7xxx and aic7xxx/aicasm.
>>  Use standard kbuild 2.4 rules.
>
>Are these documented somewhere?  I emulated "scsi/Makefile" some
>time back, but it must be out of date with current conventions.

No, you have to understand the interaction between the magic make
variables and the undocumented processing in Rules.make.  This is one
of the reasons that the new kernel build mechanism (kbuild 2.5) has
complete documentation on its language and how it works.

>Three other quick questions:
>
>1) Why doesn't "make dep" pickup the dependencies you have added
>   explicitly the aic7xxx/Makefile?  I would expect at least this
>   dependency to be picked up:
>
>+
>+# Only aic7xxx_core.c includes aic7xxx_seq.h.
>+aic7xxx_core.o: aic7xxx_seq.h
>
>    The other, indirect, dependencies (through aic7xxx.h) are picked
>    up in every other OS this driver supports.  I suppose "make dep"'s
>    shortcuts mean you have to hard code stuff to make it work.

Congratulations, you just found one of the (many) problems with make dep.
make dep is only run at the start (before aic7xxx_seq.h is generated)
and it silently ignores includes for files that do not exist at that
time.  So no dependencies for aic7xxx_seq.h are detected.

make dep does a reasonable job at dependencies for files that always
exist.  It is no good for generated files, you have to explicitly
specify such dependencies.

kbuild 2.5 is better.  You still have to tell make that a generated
file must be created before make can build anything that includes that
file, otherwise you get compile errors on a parallel build, this is a
make restriction.  However the kbuild 2.5 dependency tracking is
continuous, it is not run once like make dep, so kbuild 2.5 does more
accurate tracking of dependencies.

>2) Are there plans to allow "down tree" Makefiles to list there own
>   clean files?  Having to modify the top level Makefile is a bit messy.

Already done in kbuild 2.5.  Most clean targets are automatically
generate as a side effect of the kbuild 2.5 statements, no user action
required.  You can add your own clean and mrproper entries for the very
rare cases when they are not automatically added.

>3) Why remove the ability to override the module target name?  I eventually
>   renamed my driver's main file to avoid this issue because I will be adding
>   a second driver to the aic7xxx/Makefile (U320), but this same thing
>   will probably come up again.

Your code was the only one that tried to override the module name and
that was because your code was the only one that was breaking the
kbuild rules.  When a conglomerate object exists, all the objects that
make up that conglomerate must have unique names.  As long as you
follow the rules and do not have foo.c at the the same time as you link
multiple objects into foo.o then there are no problems.

For u320, ensure that the source is u320_core.c (not u320.c) and the
conglomerate is u320.o and there will be no problems with the module
name.

