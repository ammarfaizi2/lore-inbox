Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262943AbVCDTVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbVCDTVy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 14:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbVCDTSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 14:18:06 -0500
Received: from chaos.sr.unh.edu ([132.177.249.105]:59619 "EHLO
	chaos.sr.unh.edu") by vger.kernel.org with ESMTP id S263004AbVCDTMk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 14:12:40 -0500
Date: Fri, 4 Mar 2005 14:11:13 -0500 (EST)
From: Kai Germaschewski <kai.germaschewski@unh.edu>
X-X-Sender: kai@chaos.sr.unh.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       <kai@germaschewski.name>, Sam Ravnborg <sam@ravnborg.org>,
       Vincent Vanackere <vincent.vanackere@gmail.com>,
       <keenanpepper@gmail.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Undefined symbols in 2.6.11-rc5-mm1
In-Reply-To: <1109931797.28203.2.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0503041403470.15777-100000@chaos.sr.unh.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2005, Rusty Russell wrote:

> On Wed, 2005-03-02 at 15:00 +0100, Adrian Bunk wrote:
> > Why doesn't an EXPORT_SYMBOL create a reference?
> 
> It does: EXPORT_SYMBOL(x) drops the address of "x", including
> __attribute_used__, in the __ksymtab section.

Well, the problem is that this is still an internal reference in the same 
object file. So ld looks into the lib .a archive, determines that none of 
the symbols in that object file are needed to resolve a reference and 
drops the entire .o file. Doing so, it drops the __ksymtab section as 
well, which otherwise would be used by the kernel to look up that symbol. 

So it drops the reference and the referencee ;), which is normally fine -- 
no unresolved symbols occur. Unfortunately, the kernel really needs to 
know the contents of the __ksymtab sections to correctly export those 
symbols, but it doesn't reference it in any explicit way.

I don't think there's an easy fix, except for not putting such objects 
into an archive/lib, but to link them directly.

--Kai



