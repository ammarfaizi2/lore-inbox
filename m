Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUDAAro (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 19:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbUDAAro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 19:47:44 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:40401 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261631AbUDAArT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 19:47:19 -0500
Date: Wed, 31 Mar 2004 16:47:04 -0800 (PST)
From: Sridhar Samudrala <sri@us.ibm.com>
X-X-Sender: sridhar@localhost.localdomain
To: Peter Osterlund <petero2@telia.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, vladislav.yasevich@hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.26-rc1 - SCTP 'make xconfig' issue
In-Reply-To: <m2r7vcss6a.fsf@p4.localdomain>
Message-ID: <Pine.LNX.4.58.0403311418470.7023@localhost.localdomain>
References: <20040328042608.GA17969@logos.cnet> <m2r7vcss6a.fsf@p4.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Mar 2004, Peter Osterlund wrote:

> Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:
>
> > Sridhar Samudrala:
> >   o [SCTP] Avoid the use of hacking CONFIG_IPV6_SCTP__ option
> >
> > Please test!
>
> I get an error when selecting save and exit in "make xconfig":
>
>   ERROR - Attempting to write value for unconfigured variable (CONFIG_IP_SCTP)

Vladislav Yasevich did some investigation into this issue and he came
out with the conclusion that this is due to a bug in the parser for
'make xconfig'(tkparse). 'make menuconfig' and 'make oldconfig' should work
fine.

The parser for 'make xconfig' (tkparse)  does not handle correctly
conditionals that redefine the same variable to be of two
different types.  This is particularly pronounce when one
is a dependancy variable and the other is not.  For each
[dep_]tristate definition, the parser generates lines in
the tk script that set the variable.  Whe TK interprets it,
the end result is that the variable is set incorrectly.  I was
able to modify the TK script by hand to fix this, but the
problem seems to realy be in the tkparse parser.

He came up with the following patch that works around this issue with
tkparse.  Could you please verify if this works for you?

diff -Nru a/net/sctp/Config.in b/net/sctp/Config.in
--- a/net/sctp/Config.in	Wed Mar 31 14:22:45 2004
+++ b/net/sctp/Config.in	Wed Mar 31 14:22:45 2004
@@ -4,10 +4,10 @@
 mainmenu_option next_comment
 comment '   SCTP Configuration (EXPERIMENTAL)'

-if [ "$CONFIG_IPV6" = "n" ]; then
-  tristate '  The SCTP Protocol (EXPERIMENTAL)' CONFIG_IP_SCTP
-else
-  dep_tristate '  The SCTP Protocol (EXPERIMENTAL)' CONFIG_IP_SCTP $CONFIG_IPV6
+tristate '  The SCTP Protocol (EXPERIMENTAL)' CONFIG_IP_SCTP
+
+if [ "$CONFIG_IP_SCTP" = "y" -a "$CONFIG_IPV6" = "m" ]; then
+	define_tristate CONFIG_IP_SCTP m
 fi

 if [ "$CONFIG_IP_SCTP" != "n" ]; then

Thanks
Sridhar
