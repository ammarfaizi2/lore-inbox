Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbUKGNBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUKGNBY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 08:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbUKGNBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 08:01:24 -0500
Received: from phenix.rootshell.be ([217.22.55.50]:8332 "EHLO
	phenix.rootshell.be") by vger.kernel.org with ESMTP id S261606AbUKGNBM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 08:01:12 -0500
Date: Sun, 7 Nov 2004 14:01:03 +0100
From: rikusw <rikusw@phenix.rootshell.be>
To: linux-kernel@vger.kernel.org
Subject: Subtle Kconfig bug discovered
Message-ID: <20041107130103.GA9261@phenix.rootshell.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is a sample Kconfig file to show what this is all about.

//----snip----

#
# For a description of the syntax of this configuration file,
# see Documentation/kbuild/kconfig-language.txt.
#

menu "Kconfig problem"

config DOIT
	bool "To see what I mean set D and D1 to Y.

config TEST_A
	bool "Test A"
	default n
	help
	  Top level config

config TEST_B
	tristate "Test B"
	default n
	depends on TEST_A
	help
	  Something depending on A

config TEST_C
	bool "Test C"
	default n
	select TEST_B
	help
	  Something depending on B

config TEST_D
	bool "Test D"
	default n
	select TEST_C
	help
	  Selecting C will cause it to be Y, but what about A and B ??
	  
	  A and B is in another subsystem,
	  so D shouldn't know anything about them.

comment "Sugessted solution"

config README
	bool "Read Me in help"
	help
	  Should "depends on X" implicitly cause a "select X" ?
	  When X = 1&2&3 this is easy, but what when X = (1&2)|3 ???
	  The least LKC could do is to give a warning, if a disabled
	  option is selected.

	  I discovered this while working on fb_setup and i810fb.
	  A = I2C, B = I2C_ALGOBIT, C = I2C_I810 and D = FB_I810_I2C
	  Have a look at www.rootshell.be/~rikusw

	  The solution below doesn't require any changes to LKC,
	  the implicit select will.

config TEST_A1
	bool "Test A1"
	default n
	help

config TEST_B1
	tristate "Test B1"
	default n
	select TEST_A1
	help

config TEST_C1
	tristate "Test C1"
	default n
	select TEST_B1
	help
	  If this is bool then B1 will b Y regardless whether D1 is M or Y...

config TEST_D1
	tristate "Test D1"
	default n
	select TEST_C1
#	select TEST_B1 - I don't want this because D1 is in another subsystem
#			 and shouldn't know anything about B1.
	help

endmenu

//----snip----


I will be offline for the next 4-5 days bu, but please CC me at:
"rikusw" --> "rootshell.be"

Rikus Wessels
