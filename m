Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbWGERWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWGERWM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 13:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbWGERWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 13:22:11 -0400
Received: from mercury.realtime.net ([205.238.132.86]:27092 "EHLO
	ruth.realtime.net") by vger.kernel.org with ESMTP id S964922AbWGERWK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 13:22:10 -0400
In-Reply-To: <20060705093056.GA9906@mars.ravnborg.org>
References: <200607042157.k64LvlDd016859@sullivan.realtime.net> <200607050701.k6571Q4o018076@sullivan.realtime.net> <20060705093056.GA9906@mars.ravnborg.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9b18ca2d60e3c9a0ffc592b56cfee206@bga.com>
Content-Transfer-Encoding: 7bit
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
From: Milton Miller <miltonm@bga.com>
Subject: Re: [KBUILD] optionally print cause of rebuild (#2)
Date: Wed, 5 Jul 2006 12:20:36 -0500
To: Sam Ravnborg <sam@ravnborg.org>
X-Mailer: Apple Mail (2.624)
X-Server: High Performance Mail Server - http://surgemail.com r=-1092531819
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jul 5, 2006, at 4:30 AM, Sam Ravnborg wrote:

> Hi Milton.
>
> On Wed, Jul 05, 2006 at 02:01:26AM -0500, Milton Miller wrote:
>> Al wanted to see why Kbuild wanted to build files, to help debug
>> Makefiles or dependency chains.
> I like the idea and I have played around with it a bit before.
> To keep noise level down the "why got it rebuild" info should be on 
> same
> line as the CC command and to trigger it increasing verbose level to 2
> seems more natural.
>
> Following patch does this.
> The patch contains a few clean-ups to make the "why" part slimmer.
>
> Comments?

You gave priority of dependent files while I gave priority to command
change.   This is a judgment call, both are actually correct, but I
chose command change because changing the config will always cause
the built-in.o to be rebuilt even if you turned something back on
that you had off for a while.

You removed the subtle marker ('of') that said "here is a list of files"
vs some descriptive text (cmd change, etc); that means machine parsing
scripts have to recognize all the strings in why.

Printing it with the command like this is more compact, as long as we
enforce the rule that quiet_xxx_cmd will be of the format TAG file to
allow machine parsing. However, it does mean that for things built with 
a rule, one has to figure out why the command was invoked.

For example, mine printed
DEPS: building .tmp_vmlinux1 because of drivers/built-in.o
   GEN     .version
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
DEPS: building init/version.o because of include/linux/compile.h
   CC      init/version.o
DEPS: building init/built-in.o because of init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1

while yours does
   GEN     .version - due to: drivers/built-in.o
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o - due to: include/linux/compile.h
   LD      init/built-in.o - due to: init/version.o
   LD      .tmp_vmlinux1 - due to: drivers/built-in.o

One might wonder how .version depends on drivers/built-in.o, and
why tmp_vmlinux1 wasn't built for init/built-in.o.

We should add this to make help.


milton

