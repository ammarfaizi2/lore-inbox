Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbUJZBuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbUJZBuN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbUJZBtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:49:09 -0400
Received: from zeus.kernel.org ([204.152.189.113]:42196 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261907AbUJZBT6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:19:58 -0400
Date: Mon, 25 Oct 2004 23:32:25 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: kbuild dependencies and layout
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <1098661432l.6459l.0l@werewolf.able.es>
	<Pine.LNX.4.61.0410251556430.17266@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0410251556430.17266@scrub.home> (from
	zippel@linux-m68k.org on Mon Oct 25 16:09:43 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1098747145l.19825l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.25, Roman Zippel wrote:
> Hi,
> 
> On Sun, 24 Oct 2004, J.A. Magallon wrote:
> 
> > A_GENERIC_FEATURE_1 is valid for both submodels. Logic is right, but
> > gconfig insists on putting AF1 as a subentry of A_2, instead of hanging
> > it in the menu. I would like:
> > 
> >  A support
> >   \- A-1
> >   \- A-2
> >   \- AF1 (visible only when A-1 or A-2 are selected)
> >   \- AF2 (visible only when A-1 or A-2 are selected)
> 
> Could you please post a real example? There are two possibilities and it 
> depends on the context.

I'm trying to cleanup the config for Promise IDE, see

http://marc.theaimsgroup.com/?l=linux-kernel&m=109849081408193&w=2

Original code in drivers/ide/Kconfig for 2.6.9-mm1:

config BLK_DEV_PDC202XX_OLD
    tristate "PROMISE PDC202{46|62|65|67} support"
config PDC202XX_BURST
    bool "Special UDMA Feature"
    depends on BLK_DEV_PDC202XX_OLD
config BLK_DEV_PDC202XX_NEW
    tristate "PROMISE PDC202{68|69|70|71|75|76|77} support"
config PDC202XX_FORCE
    bool "Enable controller even if disabled by BIOS"
    depends on BLK_DEV_PDC202XX_NEW

(helps stripped...)
I want to make PDC202XX_BURST and PDC202XX_FORCE be selectable if any of
_OLD or _NEW is selected. So I wrote:

menu "Promise PDC support"
config BLK_DEV_PDC202XX_OLD
    tristate "PROMISE PDC202{46|62|65|67} support"
config BLK_DEV_PDC202XX_NEW 
    tristate "PROMISE PDC202{68|69|70|71|75|76|77} support"
config PDC202XX_BURST
    bool "Special UDMA Feature"
    depends on BLK_DEV_PDC202XX_OLD || BLK_DEV_PDC202XX_NEW
config PDC202XX_FORCE
    bool "Enable controller even if disabled by BIOS"
    depends on BLK_DEV_PDC202XX_OLD || BLK_DEV_PDC202XX_NEW
endmenu

Result (menuconfig) is:

  x x      <M> PROMISE PDC202{46|62|65|67} support                        x x  
  x x      < > PROMISE PDC202{68|69|70|71|75|76|77} support               x x  
  x x      [ ]   Special UDMA Feature (NEW)                               x x  
  x x      [ ]   Enable controller even if disabled by BIOS (NEW)         x x  

ie, the two flags are grouped inside the PDC_NEW config, instead of at
the same level.

I tried grouping things under submenus in several ways, with dummy config
variables, anyways it always ends up grouped below PDC_NEW, instead that at
the same level that both PDCs...

I have no idea on how to do it...

Any clue ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-jam1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


