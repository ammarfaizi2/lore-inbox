Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVCVRmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVCVRmc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 12:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVCVRmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 12:42:32 -0500
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:35689 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261441AbVCVRm3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 12:42:29 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: Roman Zippel <zippel@linux-m68k.org>, kbuild-devel@lists.sourceforge.net
Subject: Bug with multiple help messages, the last one is shown
Date: Tue, 22 Mar 2005 18:32:41 +0100
User-Agent: KMail/1.7.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200503221832.41883.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've verified multiple times that if we have a situation like this

bool A
depends on TRUE
help
  Bla bla1

and

bool A
depends on FALSE
help
  Bla bla2

even if the first option is the displayed one, the help text used is the one 
for the second option (the absence of "prompt" is not relevant here)!

>From a very short reading of sources, I guess that the problem is probably 
located in this line (from scripts/kconfig/zconf.y):

help: help_start T_HELPTEXT
{
        current_entry->sym->help = $2;
};

because the various current_entry values (matching the various definitions) 
share the same symbol (since of the sym_lookup call below)

config_entry_start: T_CONFIG T_WORD T_EOL
{
        struct symbol *sym = sym_lookup($2, 0);
        sym->flags |= SYMBOL_OPTIONAL;
        menu_add_entry(sym);
        printd(DEBUG_PARSE, "%s:%d:config %s\n", zconf_curname(), 
zconf_lineno(), $2);
};

Now, Kconfig handles well the same situation when there are multiple different 
prompts, instead of multiple help texts.

This because the "prompt" is added as a property with its own dependency; why 
is not this done for "help", too?
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


