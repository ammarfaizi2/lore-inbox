Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTFCSQb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 14:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbTFCSQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 14:16:31 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:24592 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261365AbTFCSQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 14:16:29 -0400
Date: Tue, 3 Jun 2003 20:29:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: strange dependancy generation bug?
Message-ID: <20030603182956.GA1175@mars.ravnborg.org>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030603120742.GA13838@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030603120742.GA13838@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 01:07:42PM +0100, Dave Jones wrote:
> Recently (about the same time that the V=0 stuff was changed over
> in kbuild), I noticed that the dependancy generation stuff seems to be
> executed more often.

> First question that springs to mind, is why does the fixdep stuff
> get run _after_ doing the compile ?

Dependency information is always generated when a file is compiled.
The build system has no knowledge about the actual changes and there can
be changes in dependencies. The dependency generation is done by the
option:
-Wp,-MD,arch/i386/kernel/cpu/cpufreq/.powernow-k7.o.d

This tell the preprocessor to generate a makefile fragment
that includes all dependencies.
But this is not enough - a file must be recompiled if one of the CONFIG_
options used in that particualr file - or any of the dependencies - has
changed.
Therefore the second step is to run the fixdep command.
Fixdep parses all included files, and when it see a CONFIG_* symbol
it generate a dependency on the corresponding file located in
include/config/*

split-config has already updated a hirachy of files from the
active .config. When .config is changed relevant files under
include/config/* are updated. Relevant files represent only changed
config options.

fixdep is called with the commandline as argument. this is used by kbuild
to detect changes in command line parameters. If any flags are changed
this will force a recompile as well.

> Second, is why does this always happen? Even on subsequent builds.
As explained above fixdep needs to be run each time a file is
compiled.

But the real question is why you start seeing the invocation
of fixdep. I do not see it on my machine.
I asssume that you see fixdep invocation even with "make V=0".
This is a bug!

Counting this one I have now three independent reports where
kbuild displayed the invocation of fixdep.

I have tried to narrow down the root cause.
Both users were running debian unstable.
Different shells.
GNU make 3.80

I tried to install GNU make 3.80 - but I still do not see the problem.
What happens is that within Makefile.build there is used multi line
definition, where each new-line causes make to launch a new sub-shell.
The command for the second sub-shell is echoed, even though make is told
not to do so. 

I have a patch to fix this that I will send to Linus tonight.

	Sam
