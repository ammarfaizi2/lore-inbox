Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265943AbUGMVQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUGMVQQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 17:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbUGMVQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 17:16:16 -0400
Received: from mail.gmx.de ([213.165.64.20]:51355 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265943AbUGMVPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 17:15:34 -0400
X-Authenticated: #23026389
From: "Alexander \"ghostrile\" Bierbrauer" <abierbrauer@gmx.org>
To: linux-kernel@vger.kernel.org
Subject: reading the kernel configuration using libkconfig.so
Date: Tue, 13 Jul 2004 23:10:07 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407132310.07170.abierbrauer@gmx.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

I've started to code a tool for exporting the kernel configuration to a HTML 
file (inkl trees and so on.. could be used for HowTos). I've read qconf.cc 
gconf.c from /usr/src/linux/sripts/kconfig.

So far, so good.. the code compiles without any hassles... but I'm getting the 
following messages when I want to run my program (e.g. 
in /home/nomore/dev/lktexporter):

Code:

bash-2.05b$ ./lktexporter
/usr/src/linux/.config:4: syntax error, unexpected T_WORD
/usr/src/linux/.config:9: syntax error
/usr/src/linux/.config:12: syntax error, unexpected T_WORD
/usr/src/linux/.config:17: syntax error
/usr/src/linux/.config:20: syntax error, unexpected T_WORD
/usr/src/linux/.config:40: syntax error
/usr/src/linux/.config:43: syntax error, unexpected T_WORD
/usr/src/linux/.config:50: syntax error
/usr/src/linux/.config:53: syntax error, unexpected T_WORD
/usr/src/linux/.config:111: syntax error
/usr/src/linux/.config:115: syntax error, unexpected T_WORD
/usr/src/linux/.config:124: syntax error
/usr/src/linux/.config:127: syntax error, unexpected T_WORD
/usr/src/linux/.config:131: syntax error
/usr/src/linux/.config:134: syntax error, unexpected T_WORD
/usr/src/linux/.config:155: syntax error
/usr/src/linux/.config:163: syntax error, unexpected T_WORD


the first lines of the example config
Code:

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y


I don't know what I'm doing wrong.. and can't see the differnece between my 
code and the ones from the kernel config tools. 'make menuconfig' is working 
with the above config file.

Here's my code so far:
Code:

#define LKC_DIRECT_LINK

#include <stdlib.h>
#include "lkc.h"


void fixup_rootmenu(struct menu *menu)
{
   struct menu *child;
   static int menu_cnt = 0;

   menu->flags |= MENU_ROOT;
   for (child = menu->list; child; child = child->next) {
      if (child->prompt && child->prompt->type == P_MENU) {
         menu_cnt++;
         fixup_rootmenu(child);
         menu_cnt--;
      } else if (!menu_cnt)
         fixup_rootmenu(child);
   }
}

void exportConfig(struct menu *menu)
{
   struct symbol *sym;
   struct property *prop;
   struct menu *child,*current;
   enum prop_type ptype;

   if (menu == &rootmenu) {
      current = &rootmenu;
   }

   //going through the complete list
   for (child = menu->list; child; child = child->next)
   {
      prop = child->prompt;
      sym = child->sym;
      ptype = prop ? prop->type : P_UNKNOWN;

      printf("prompt: %s\n",menu_get_prompt(child));      
   }
}

int main(int argc,char **argv)
{
   #ifndef LKC_DIRECT_LINK
   kconfig_load();
   #endif

   //reading the kernel configuration
   conf_parse("/usr/src/linux/.config");
   fixup_rootmenu(&rootmenu);
   
   if(conf_read(NULL))
   {
      printf("unable to load linux kernel configuration\n");
      return 1;
   }

   exportConfig(&rootmenu);

   return 0;
}


I've searched the web and the archives but didn't find any answers. If this 
isn't the right place for my questions, then would you please tell me where I 
can ask ?? 
Is there any place to get some neat documentation ?? And why isn't the code of 
the config tools documentated ? *argh* :]

any help is great !

Alexander
