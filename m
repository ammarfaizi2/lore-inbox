Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbVGJUeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVGJUeW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 16:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVGJTlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:41:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:24796 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261207AbVGJTfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:23 -0400
Date: Sun, 10 Jul 2005 19:35:21 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Greg KH <gregkh@suse.de>
Subject: [PATCH 13/82] remove linux/version.h from drivers/char/speakup/
Message-ID: <20050710193521.13.ifqbfm2621.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.

remove code for obsolete kernel versions

Signed-off-by: Olaf Hering <olh@suse.de>
drivers/char/speakup/genmap.c            |    3 +--
drivers/char/speakup/makemapdata.c       |    1 -
drivers/char/speakup/mod_code.c          |    3 ---
drivers/char/speakup/speakup.c           |   26 --------------------------
drivers/char/speakup/speakup_drvcommon.c |    3 ---
drivers/char/speakup/speakup_keyhelp.c   |    7 -------
drivers/char/speakup/spk_priv.h          |    6 ------
include/linux/speakup.h                  |    2 --
8 files changed, 1 insertion(+), 50 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/char/speakup/genmap.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/char/speakup/genmap.c
+++ linux-2.6.13-rc2-mm1/drivers/char/speakup/genmap.c
@@ -2,7 +2,6 @@
#include <stdio.h>
#include <libgen.h>
#include <string.h>
-#include <linux/version.h>
#include <ctype.h>

int get_define(void);
@@ -42,7 +41,7 @@ void open_input( char *name )
{
strcpy( filename, name );
if ( ( infile = fopen( filename, "r" ) ) == 0 ) {
-		fprintf( stderr, "can't open %s, version %dn", filename, LINUX_VERSION_CODE );
+		fprintf( stderr, "can't open %sn", filename);
exit( 1 );
}
lc = 0;
Index: linux-2.6.13-rc2-mm1/drivers/char/speakup/makemapdata.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/char/speakup/makemapdata.c
+++ linux-2.6.13-rc2-mm1/drivers/char/speakup/makemapdata.c
@@ -2,7 +2,6 @@
#include <stdio.h>
#include <libgen.h>
#include <string.h>
-#include <linux/version.h>
#include <ctype.h>

int get_define(void);
Index: linux-2.6.13-rc2-mm1/drivers/char/speakup/mod_code.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/char/speakup/mod_code.c
+++ linux-2.6.13-rc2-mm1/drivers/char/speakup/mod_code.c
@@ -12,9 +12,6 @@ static int __init mod_synth_init( void )
int status = do_synth_init( &MY_SYNTH );
if ( status != 0 ) return status;
synth_add( &MY_SYNTH );
-#if (LINUX_VERSION_CODE < 132419)
-//          MOD_INC_USE_COUNT;
-#endif
return 0;
}

Index: linux-2.6.13-rc2-mm1/drivers/char/speakup/speakup.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/char/speakup/speakup.c
+++ linux-2.6.13-rc2-mm1/drivers/char/speakup/speakup.c
@@ -25,16 +25,10 @@
#define __KERNEL_SYSCALLS__

#include <linux/kernel.h>
-#include <linux/version.h>
#include <linux/vt.h>
#include <linux/tty.h>
#include <linux/mm.h> /* __get_free_page( ) and friends */
#include <linux/vt_kern.h>
-#if (LINUX_VERSION_CODE < 132419)
-#include <linux/console_struct.h>
-#include <linux/kbd_ll.h>
-#include <asm/keyboard.h>
-#endif
#include <linux/ctype.h>
#include <linux/selection.h>
#include <asm/uaccess.h> /* copy_from|to|user( ) and others */
@@ -109,19 +103,12 @@ static u_char key_defaults[] = {
#include "speakupmap.h"
};

-#if (LINUX_VERSION_CODE < 132419)
-extern struct tty_struct *tty;
-typedef void (*k_handler_fn)(unsigned char value, char up_flag);
-#define KBD_PROTO u_char value, char up_flag
-#define KBD_ARGS value, up_flag
-#else
struct tty_struct *tty;
#define key_handler k_handler
typedef void (*k_handler_fn)(struct vc_data *vc, unsigned char value,
char up_flag, struct pt_regs *regs);
#define KBD_PROTO struct vc_data *vc, u_char value, char up_flag, struct pt_regs *regs
#define KBD_ARGS vc, value, up_flag, regs
-#endif
extern k_handler_fn key_handler[16];
static k_handler_fn do_shift, do_spec, do_latin, do_cursor;
EXPORT_SYMBOL( help_handler );
@@ -1293,9 +1280,7 @@ void __init speakup_open (struct vc_data
speakup_date( vc);
pr_info ("%s: initializedn", SPEAKUP_VERSION );
init_timer (&cursor_timer );
-#if (LINUX_VERSION_CODE >= 132419)
cursor_timer.entry.prev=NULL;
-#endif
cursor_timer.function = cursor_done;
init_sleeper ( synth_sleeping_list );
strlwr (synth_name );
@@ -2088,13 +2073,8 @@ load_help ( void *dummy )
} else synth_write_string( "help module not found" );
}

-#if (LINUX_VERSION_CODE >= 132419)
static DECLARE_WORK(ld_help, load_help, NULL);
#define schedule_help schedule_work
-#else
-static struct tq_struct ld_help = { routine: load_help, };
-#define schedule_help schedule_task
-#endif

static void
speakup_help (struct vc_data *vc )
@@ -2161,18 +2141,12 @@ void do_spkup( struct vc_data *vc,u_char
static const char *pad_chars = "0123456789+-*/015,.?()";

int
-#if (LINUX_VERSION_CODE < 132419)
-speakup_key ( int shift_state, u_char keycode, u_short keysym, u_char up_flag )
-#else
speakup_key (struct vc_data *vc, int shift_state, int keycode, u_short keysym, int up_flag, struct pt_regs *regs )
-#endif
{
u_char *key_info;
u_char type = KTYP( keysym ), value = KVAL( keysym ), new_key = 0;
u_char shift_info, offset;
-#if (LINUX_VERSION_CODE >= 132419)
tty = vc->vc_tty;
-#endif
if ( synth == NULL ) return 0;
if ( type >= 0xf0 ) type -= 0xf0;
if ( type == KT_PAD && (vc_kbd_led(kbd , VC_NUMLOCK ) ) ) {
Index: linux-2.6.13-rc2-mm1/drivers/char/speakup/speakup_drvcommon.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/char/speakup/speakup_drvcommon.c
+++ linux-2.6.13-rc2-mm1/drivers/char/speakup/speakup_drvcommon.c
@@ -1,6 +1,5 @@
#define KERNEL
#include <linux/config.h>
-#include <linux/version.h>
#include <linux/types.h>
#include <linux/ctype.h>	/* for isdigit( ) and friends */
#include <linux/fs.h>
@@ -304,9 +303,7 @@ int do_synth_init ( struct spk_synth *in
synth_time_vars[2].default_val = synth->jiffies;
synth_time_vars[3].default_val = synth->full;
synth_timer.function = synth->catch_up;
-#if (LINUX_VERSION_CODE >= 132419)
synth_timer.entry.prev = NULL;
-#endif
init_timer ( &synth_timer );
for ( n_var = synth_time_vars; n_var->var_id >= 0; n_var++ )
speakup_register_var( n_var );
Index: linux-2.6.13-rc2-mm1/drivers/char/speakup/speakup_keyhelp.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/char/speakup/speakup_keyhelp.c
+++ linux-2.6.13-rc2-mm1/drivers/char/speakup/speakup_keyhelp.c
@@ -20,7 +20,6 @@
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

-#include <linux/version.h>
#include <linux/keyboard.h>
#include "spk_priv.h"

@@ -201,9 +200,6 @@ static int handle_help ( struct vc_data
if ( type == KT_LATIN ) {
if ( ch == SPACE ) {
special_handler = NULL;
-#if (LINUX_VERSION_CODE < 132419)
-			MOD_DEC_USE_COUNT;
-#endif
synth_write_msg( "leaving help" );
return 1;
}
@@ -224,9 +220,6 @@ static int handle_help ( struct vc_data
else return -1;
} else if (type == KT_SPKUP && ch == SPEAKUP_HELP && !special_handler) {
special_handler = help_handler;
-#if (LINUX_VERSION_CODE < 132419)
-		MOD_INC_USE_COUNT;
-#endif
synth_write_msg( help_info );
build_key_data( ); /* rebuild each time in case new mapping */
return 1;
Index: linux-2.6.13-rc2-mm1/drivers/char/speakup/spk_priv.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/char/speakup/spk_priv.h
+++ linux-2.6.13-rc2-mm1/drivers/char/speakup/spk_priv.h
@@ -25,7 +25,6 @@
#define __SPEAKUP_PRIVATE_H

#define KERNEL
-#include <linux/version.h>
#include <linux/config.h>
#include <linux/types.h>
#include <linux/fs.h>
@@ -209,13 +208,8 @@ void spk_serial_release( void );
extern int synth_port_tts, synth_port_forced;
extern volatile int synth_timer_active;
#define declare_timer( name ) struct timer_list name;
-#if (LINUX_VERSION_CODE >= 132419)
#define start_timer( name ) if ( ! name.entry.prev ) add_timer ( & name )
#define stop_timer( name ) del_timer ( & name ); name.entry.prev = NULL
-#else
-#define start_timer( name ) if ( ! name.list.prev ) add_timer ( & name )
-#define stop_timer( name ) del_timer ( & name )
-#endif
#define declare_sleeper( name ) wait_queue_head_t name
#define init_sleeper( name ) 	init_waitqueue_head ( &name )
extern declare_sleeper( synth_sleeping_list );
Index: linux-2.6.13-rc2-mm1/include/linux/speakup.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/include/linux/speakup.h
+++ linux-2.6.13-rc2-mm1/include/linux/speakup.h
@@ -1,8 +1,6 @@
#ifndef __SPEAKUP_H
#define __SPEAKUP_H

-#include <linux/version.h>
-
struct kbd_struct;
struct vc_data;

