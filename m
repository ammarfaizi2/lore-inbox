Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262779AbSKTVvS>; Wed, 20 Nov 2002 16:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262790AbSKTVvR>; Wed, 20 Nov 2002 16:51:17 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:5523 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262779AbSKTVvP>;
	Wed, 20 Nov 2002 16:51:15 -0500
Message-ID: <3DDC051F.2060904@us.ibm.com>
Date: Wed, 20 Nov 2002 13:56:47 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] early command-line parsing
References: <3DDBD70B.7090501@us.ibm.com> <24571.1037826022@passion.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> Not all architectures have asm/setup.h. And not all have the command line 
> somewhere convenient before setup_arch runs, although that could perhaps be 
> changed.
> 
> I wonder if calling checksetup(0, ...) should be called from setup_arch as 
> soon as the command line is available, rather than in start_kernel().

11 of the 18 architectures that I looked at do some form of their own 
command-line parsing.  There is a lot of arch code that could be saved 
if they could use the __setup mechanisms for this.
	
As far as the architectures that don't have the command-line 
available, we could do something like this:
void start_kernel(void)
{
         char * command_line;
         extern char saved_command_line[];

	get_command_line_arch(&saved_command_line);
	strcpy(command_line, saved_command_line);
	checksetup(0, ...)
	...
}

The weird ones like sparc could do their prom_getcmdline() in 
get_command_line_arch();

Use of command line in setup_arch:
---------------------------------
alpha	does parsing in setup_arch
  	modifies read command line, in case of INSTALL

arm	has its own command-line parsing function

cris	doesn't use a command line

i386	has its own parse_cmdline_early
	can use command line before setup_arch

ia64	the only thing that happens before the strcopy is unw_init

m68k	does its own parsing
	can modify the cmd line in m68k_parse_bootinfo(), which is
  	  early in setup_arch()

mips	many per-arch setups first
	next after those is cmdline copy

ppc+64	does a bit of its own parsing for the debuggers

s390+x	does its own parsing for mem=, and others

sh	has own early printk
	does its own parsing

sparc	get cmdline from prom call
and 64	does own parsing in boot_flags_init()
	
um	cmdline copy happens after paging_init() in setup_arch

v850	does cmdline copy, first thing

x86_64	does its own parsing for early_printk, and in
	  parse_cmdline_early
-- 
Dave Hansen
haveblue@us.ibm.com

