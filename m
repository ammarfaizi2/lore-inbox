Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261537AbTCOUOs>; Sat, 15 Mar 2003 15:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261538AbTCOUOr>; Sat, 15 Mar 2003 15:14:47 -0500
Received: from pasky.ji.cz ([62.44.12.54]:13049 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S261537AbTCOUOl>;
	Sat, 15 Mar 2003 15:14:41 -0500
Date: Sat, 15 Mar 2003 21:25:28 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Mitch Adair <mitch@theneteffect.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: 2.5.64: menuconfig: help within choice blocks doesn't show?
Message-ID: <20030315202528.GA31875@pasky.ji.cz>
Mail-Followup-To: Mitch Adair <mitch@theneteffect.com>,
	linux-kernel@vger.kernel.org
References: <200303151942.h2FJgwP19650@mako.theneteffect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303151942.h2FJgwP19650@mako.theneteffect.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sat, Mar 15, 2003 at 08:42:58PM CET, I got a letter,
where Mitch Adair <mitch@theneteffect.com> told me, that...
> I've noticed the help text for menuconfig options doesn't show if it's inside
> a Kconfig choice block.  For example under "Processor type and features" ->
> "Processor family" none of the help shows for the processor types even
> though the help texts are present in the Kconfig file.
> 
> Is anybody else seeing this?

Me too, the following patch does it differently, although still wrong ;-).

  Hello,

  this patch (against 2.5.64) will display help of the actually selected item
inside of a choice menu, instead of the choice's item itself. Ie. for processor
type item dialog, it will display help for the currently chosen processor
(Pentium 4) instead of the generic help for the "Processor type" menu.

  This is not meant to be merged, not even used, as it is confusing this way.
It doesn't care about the item being _selected_ (by cursor keys), but _chosen_
(by space or enter being pressed). So if the value of processor type is P4, it
will show help for P4 even if the cursor is now at i486. Unfortunately with the
current output of lxdialog we can't do it in the right way, one more reason for
me to finally finish the lxdialog integration ;-). In the meantime, if anyone
wants to, he might hack lxdialog and mconf together and provide sufficient
output to implement this in the right way. Let this be the inspiration.

  Duh, this description is crap (and took me more time to write than the patch
itself :). Better go and see yourself, if you want.

 scripts/kconfig/mconf.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletion(-)

  Kind regards,
				Petr Baudis

--- linux+pasky/scripts/kconfig/mconf.c	Wed Feb  5 12:11:02 2003
+++ linux/scripts/kconfig/mconf.c	Sat Mar 15 21:08:47 2003
@@ -618,7 +618,25 @@ static void conf_choice(struct menu *men
 			sym_set_tristate_value(menu->sym, yes);
 			return;
 		case 1:
-			show_help(menu);
+			{
+				struct menu *active_menu = NULL;
+
+				/* Show help for the actual choice, if available. */
+
+				for (child = menu->list; child; child = child->next) {
+					if (menu_is_visible(child)
+					    && child->sym == active) {
+						if (!child->sym->help)
+							break;
+						active_menu = child;
+					}
+				}
+
+				if (active_menu)
+					show_help(active_menu);
+				else
+					show_help(menu);
+			}
 			break;
 		case 255:
 			return;
