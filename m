Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267483AbUHSWch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267483AbUHSWch (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 18:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267482AbUHSWcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 18:32:36 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:46000 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S267484AbUHSWcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 18:32:11 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 20 Aug 2004 00:31:12 +0200
To: schilling@fokus.fraunhofer.de, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: GNU make alleged of "bug" (was: PATCH: cdrecord: avoiding scsi 
 device numbering for ide devices)
Message-ID: <41252A30.nail8D551I5Z2@burner>
References: <200408191600.i7JG0Sq25765@tag.witbe.net>
 <200408191341.07380.gene.heskett@verizon.net>
 <20040819194724.GA10515@merlin.emma.line.org>
 <20040819220553.GC7440@mars.ravnborg.org>
 <20040819205301.GA12251@merlin.emma.line.org>
In-Reply-To: <20040819205301.GA12251@merlin.emma.line.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> > Using:
> > -include hello.d
> > will result in a silent make.
>
> Indeed it will. However, Solaris' /usr/ccs/bin/make doesn't understand
> the "-include" form:
>
> make: Fatal error in reader: Makefile, line 5: Unexpected end of line seen
>
> include without leading "-" is fine. BSD make doesn't understand either
> form.
>
> J?rg, how about Sam's suggestion? It seems compatible with smake.

-include does not work with Sun's make and it does not cure the bug in GNU make
but hides it only.

GNU make just violates the unwritten "golden rule" for all make programs:

	If you like to "use" anything, first check whether you have a rule
	that could make the file in question.

For makefiles on the Command Line, GNU make follows this rule. If you are in an 
empty directory and call "gmake", GNU make will first try if "Makefile" or 
"makefile" could be retrieved using e.g. "sccs get Makefile" before GNU make 
tries to read the file.

For makefiles that appear as argument to an include statement, GNU make ingnores
this rule. GNU make instead, later (too late) executes the rule set and creates 
the missing files using known rules. In order to be able to do anything useful, 
GNU make then executes "exec gmake <old arg list>" after it is done with 
executing the rules. This is complete nonsense.

Smake works this way:

-	if it is going to "include" a file, it checks whether there is a rule 
	to make the file that is going to be included.

-	If the file has been "made", smake includes the file.

-	After including the file, smake clears the "has been made already" 
	cache flags for the included file.

-	After all make files and all recursive include rules have been made and 
	included, smake checks all rules again. This may result in rare cases 
	that the rule for one of the the include file is executed again.

As you noe see that GNU make behaves inconsistent, I hope you believe me that 
there is a bug in GNU make that should be fixed.



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
