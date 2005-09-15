Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbVIOLVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbVIOLVn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 07:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbVIOLVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 07:21:43 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:6893 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750770AbVIOLVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 07:21:42 -0400
Date: Thu, 15 Sep 2005 13:21:39 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Automatic Configuration of a Kernel
In-Reply-To: <20050914223836.53814.qmail@web51011.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0509151253120.3743@scrub.home>
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 14 Sep 2005, Ahmad Reza Cheraghi wrote:

> I wrote this Framework for making a .config based on
> the System Hardwares. It would be a great help if some
> people would give me their opinion about it.

How interested are you in finishing this project?
I'm asking because the major part is still ahead of you and I'm not sure 
how much further you want to take it take it beyond your university 
project.

The basic problem is that maintaining the bulk of autoconfig information 
in a separate file is not feasible, it would be a nightmare to maintain.
This means it would be better to integrate this information into Kconfig 
and define interface so that external program/scripts (preferably shell 
instead of perl) can use that to configure the kernel.

A simple example could look like this:

config FOO
	bool "foo"
	def_auto y

Internally this would become:

config FOO
	bool "foo" if !AUTO_CONFIG
	default y if AUTO_CONFIG

AUTO_CONFIG could also be used to ask some simple questions for things 
that can't be automatically configured and these answers can be used to 
adjust other parameters, e.g.:

config AUTO_SERVER
	bool "Configure for a server"
	depends on AUTO_CONFIG

config BAR
	bool "blah"
	def_auto AUTO_SERVER

Driver configuration might look something like this:

module foo
	tristate "foo support"

Kconfig would generate a config symbol FOO and a Makefile entry for this.
Autoconfiguration could now either look like this:

module foo
	pci_map VENDOR DEVICE [...]

or we just an option and extract the data from the source:

module foo 
	option pci

In either case Kconfig would feed this data an to external program which 
matches it with the existing data and returns the matching config symbols 
(the matching process would be pretty much like what hotplug already 
does).

As you can see a proper integration would require a bit of work, I can 
help with Kconfig related parts, but it needs integration into several 
systems. The end result would be much more useful. Instead of maintaining 
another file, the data is shared and automatically updated by the relevant 
system.

bye, Roman
