Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318864AbSIIUid>; Mon, 9 Sep 2002 16:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318844AbSIIUhO>; Mon, 9 Sep 2002 16:37:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:49615 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318870AbSIIUgj>; Mon, 9 Sep 2002 16:36:39 -0400
Date: Mon, 9 Sep 2002 22:41:16 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Mario Vanoni <vanonim@bluewin.ch>, Alan Cox <alan@redhat.com>,
       Andre Hedrick <andre@linux-ide.org>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4-pre5[{-}xyz]: 4 machines, feedback only
In-Reply-To: <3D7BA992.113333E@bluewin.ch>
Message-ID: <Pine.NEB.4.44.0209092234120.11139-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Sep 2002, Mario Vanoni wrote:

>...
> 2.4.20-pre5-ac4: gr4 & va1 OK, >24h
>                  gr5 & va3 _not_ compilable,
>                  at ide/idedriver.o stop
>...


Mario sent me in a private mail the .configs. He answered at
"make *config" that he didn't read the release notes. That's good because
it uncovered the following that is a real bug:

<--  snip  -->

...
        --end-group \
        -o vmlinux
drivers/ide/idedriver.o: In function `proc_ide_read_drivers':
drivers/ide/idedriver.o(.text+0x3fe): undefined reference to `ide_modules'
drivers/ide/idedriver.o: In function `proc_ide_read_identify':
drivers/ide/idedriver.o(.text+0x635): undefined reference to
`taskfile_lib_get_identify'
drivers/ide/idedriver.o: In function `proc_ide_read_settings':
drivers/ide/idedriver.o(.text+0x73d): undefined reference to
`ide_read_setting'
drivers/ide/idedriver.o: In function `proc_ide_write_settings':
drivers/ide/idedriver.o(.text+0x977): undefined reference to
`ide_find_setting_by_name'
drivers/ide/idedriver.o(.text+0x9a2): undefined reference to
`ide_write_setting'
drivers/ide/idedriver.o: In function `proc_ide_write_driver':
drivers/ide/idedriver.o(.text+0xbfb): undefined reference to
`ide_replace_subdriver'
drivers/ide/idedriver.o: In function `create_proc_ide_drives':
drivers/ide/idedriver.o(.text+0xdbb): undefined reference to
`generic_subdriver_entries'
drivers/ide/idedriver.o: In function `create_proc_ide_interfaces':
drivers/ide/idedriver.o(.text+0xf44): undefined reference to `ide_hwifs'
drivers/ide/idedriver.o(.text+0xf49): undefined reference to `ide_hwifs'
drivers/ide/idedriver.o(.text+0xf4e): undefined reference to `ide_hwifs'
drivers/ide/idedriver.o: In function `destroy_proc_ide_interfaces':
drivers/ide/idedriver.o(.text+0xfa8): undefined reference to `ide_hwifs'
drivers/ide/idedriver.o(.text+0xfad): undefined reference to `ide_hwifs'
drivers/ide/idedriver.o(.text+0xfb2): more undefined references to
`ide_hwifs' follow
make: *** [vmlinux] Error 1

<--  snip  -->


ide-proc.c is compiled into idedriver.o even if no IDE support is compiled
into the kernel. That isn't new. The problem that causes these undefined
references is that in -ac4 some functions that use functions from other
ide files (which aren't compiled when building a kernel without IDE
support) are no longer static (because they are now exported to modules).


> Regards
>
> Mario, _not_ in lmkl
>...

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



