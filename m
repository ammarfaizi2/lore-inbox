Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287526AbSAEGCx>; Sat, 5 Jan 2002 01:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287540AbSAEGCo>; Sat, 5 Jan 2002 01:02:44 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:57353 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287526AbSAEGCZ>;
	Sat, 5 Jan 2002 01:02:25 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: pwd@mdtsoft.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Update to the make rpm system kernel 2.4.17 and 2.5.1 
In-Reply-To: Your message of "Fri, 04 Jan 2002 15:05:37 CDT."
             <200201042005.g04K5bZ19255@mdtsoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 05 Jan 2002 17:02:11 +1100
Message-ID: <7074.1010210531@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002 15:05:37 -0500 (EST), 
pwd@mdtsoft.com wrote:
>I needed to be able to build a bit more complex set of rpm files than
>the make rpm function allowed. Attached is a patch that will replace
>the scripts/mkspec file with a perl program that generates a bit better
>spec file, the change to the top level Makefile that will use perl not
>bash for mkspec and a file for the Doc... directory explaining the changes.
>
>If there is anyone using the make rpm could take a look at this and let
>me know if it works with your build. I have tested this under a production
>build based on 2.4.17 and a build with default configuration under 2.5.1
>(I can't build any of my standard configuration for 2.5.1 due to buslogic
>dirver problems) and it does what I intended it to.

In kernel build 2.5 the make rpm target does not exist.  kbuild 2.5
builds the kernel and modules, installs the kernel, modules, System.map
and .config, that is _all_ it does.  Extra tasks like updating
bootloader files or building a package using the packaging method of
the month are _not_ part of kbuild 2.5.  Every user wants to do
something different with bootloaders and packaging, there is no "one
size fits all" script.

Having said that, kbuild 2.5 is extensible.  You can specify additional
targets and commands to do whatever special processing the user wants.
I have no problem with kbuild 2.5 shipping /sample/ scripts to do extra
processing, but it will not invoke them directly.  Users copy the
sample code to their own directories and change it, then tell kbuild to
execute the copy that does exactly what this user wants.  From
Documentation/kbuild/kbuild-2.5.txt:

ADDITIONAL TARGETS AND COMMANDS

  Some users will want to execute additional commands as part of kbuild.  In
  particular users who generate kernel packages will want to run their own
  commands after make install.  Instead of polluting the kbuild Makefiles
  with rules that have nothing to do with kernel building, kbuild 2.5
  supports user defined additional commands, using variables ADD0 through
  ADD9, with the corresponding ADD[0-9]_DEP and ADD[0-9]_CMD.  A command like

    make ADD0=pkg ADD0_DEP=install ADD0_CMD='my-package-script' pkg

  Will make target 'pkg', which is defined by ADD0.  It has a dependency
  (ADD0_DEP) of install so the install process runs first.  After install has
  completed, command my-package-script (ADD0_CMD) is run.  The command can be
  shell commands separated by ';' but will normally be a distribution
  specific script.  The command has access to all the config variables plus
  the variables that define the kernel, including KERNELRELEASE.

  It is the responsibility of the packager to maintain their own scripts.
  kbuild will not maintain scripts for every packaging manager used by every
  distribution.

  Because of the way that the .config variables are read by kbuild, you can
  specify a CONFIG_ variable on the make command line and it will override
  the value used by the makefiles.  In general this is not safe because the
  config values read during the compile stage are set by another mechanism so
  overriding a config variable on the command line when that variable is used
  in code will generate inconsistent results.

  However there are some config variables that can be safely specified on the
  make command line because they are only used by the makefiles.  All these
  variables start with CONFIG_INSTALL_, they define where the kernel,
  modules, map, .config etc. are installed.  Obviously a packaging system
  will want to set some of these values on the command line.  See the top
  level Makefile.in for the current CONFIG_INSTALL_ variables.

