Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbTHXUjm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 16:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTHXUjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 16:39:42 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:42713 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id S261304AbTHXUjj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 16:39:39 -0400
Date: Sun, 24 Aug 2003 22:34:26 +0200
To: linux-kernel@vger.kernel.org
Cc: zippel@linux-m68k.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] Make menuconfig display helptext in "choice" menus.
Message-ID: <20030824203426.GA11071@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *19r1ZC-0004xB-00*R7phmYLKqP.*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

found an old patch lingering in my tree. It fixes the annoying problem that
helptext can't be displayed in choicemenus with menuconfig.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1292, 2003-08-24 22:22:55+02:00, andersg@0x63.nu
  Make menuconfig display helptext in "choice" menus.


 kconfig/mconf.c      |   20 ++++++++++++++++----
 lxdialog/checklist.c |    3 ++-
 2 files changed, 18 insertions(+), 5 deletions(-)


diff -Nru a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
--- a/scripts/kconfig/mconf.c	Sun Aug 24 22:26:52 2003
+++ b/scripts/kconfig/mconf.c	Sun Aug 24 22:26:52 2003
@@ -607,6 +607,7 @@
 	struct symbol *active;
 	int stat;
 
+	active = sym_get_choice_value(menu->sym);
 	while (1) {
 		cprint_init();
 		cprint("--title");
@@ -618,13 +619,18 @@
 		cprint("6");
 
 		current_menu = menu;
-		active = sym_get_choice_value(menu->sym);
 		for (child = menu->list; child; child = child->next) {
 			if (!menu_is_visible(child))
 				continue;
 			cprint("%p", child);
 			cprint("%s", menu_get_prompt(child));
-			cprint(child->sym == active ? "ON" : "OFF");
+			if (sym_get_choice_value(menu->sym) == child->sym) {
+				cprint("ON");
+			}else if (active== child->sym) {
+				cprint("SELECTED");
+			}else{
+				cprint("OFF");
+			}
 		}
 
 		stat = exec_conf();
@@ -634,9 +640,15 @@
 				break;
 			sym_set_tristate_value(menu->sym, yes);
 			return;
-		case 1:
-			show_help(menu);
+		case 1: {
+			struct menu *tmp;
+			if (sscanf(input_buf, "%p", &tmp) == 1) {
+				show_help(tmp);
+				active=tmp->sym;
+			} else
+				show_help(menu);
 			break;
+		}
 		case 255:
 			return;
 		}
diff -Nru a/scripts/lxdialog/checklist.c b/scripts/lxdialog/checklist.c
--- a/scripts/lxdialog/checklist.c	Sun Aug 24 22:26:52 2003
+++ b/scripts/lxdialog/checklist.c	Sun Aug 24 22:26:52 2003
@@ -138,7 +138,7 @@
     /* Initializes status */
     for (i = 0; i < item_no; i++) {
 	status[i] = !strcasecmp (items[i * 3 + 2], "on");
-	if (!choice && status[i])
+	if ((!choice && status[i]) || (!strcasecmp (items[i * 3 + 2], "selected")))
             choice = i;
     }
 
@@ -302,6 +302,7 @@
 	case 'H':
 	case 'h':
 	case '?':
+	    fprintf (stderr, "%s", items[(scroll + choice) * 3]);
 	    delwin (dialog);
 	    free (status);
 	    return 1;

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


M'XL( (P?23\  \U6:V_;-A3];/Z*6Q<+[*:V^-#++EQD2](M6+<&Z?JI" R:
MHFW!>D&DG&33_ONN)"=+C#7IV@TH+8#@XQZ>>WD.X>?PP>ARVI-9I$NS(L_A
MI]S8:8]>^V*<53B^R',<.Y&TTHGTUMGH,M.)L]@XBR2_(KCC7%JUABW&3WML
M+.YF[$VAI[V+TQ\_O/W^@I#9#([7,EOI]]K";$9L7FYE$IDC:==)GHUM*3.3
M:BO'*D_KNZTUIY3CSV.!H)Y?,Y^Z0:U8Q)ATF8XH=T/?)=LXDS>C4AUETE:E
M-OG2CC-M/]Z><OD04="0"\:YX*+V?,_SR0FP,>,3#E0X-'2X"YQ/\?.\0\JG
ME,*N1$>[TL AAQ$E/\!_F\<Q4?"+W&A(=5:I/%O&*XAB4R3R!M8Z*:R^MA!G
MT%?K/%:ZW^XS8_(S>"+T G+^=Y')Z%\V0JBDY/43&1E5QH4U3G(=Q3+)5XY:
M:[5)8F/'ZEZ2+A5^33WJ3^I)N-2!YP:!B#1?\'"_E$]"-K?E<LI"3FON^:Y 
MDK_'1:&3HR3.JNM1ZH>;<5ZN[EWW+>:F*Z*3-OV.(4-$Z@K.1"VH<&F]G$QD
M)"(V45X81,+_),-_0+M/SA>3(&BE_EA*3ZO_ZVM,BL:#7X,>TH"*&M7JL=8<
M[@-GL'#*Z2/.8-^0,SK)O(-1>=5^J/3S1R_H"YQSPEP&C)QU72]>PF#PK&,"
M!P=@+#Y+YF-\.82ZAL$S8TLEC59I 8/8ZA27X 4(. 1^^1+Z1B=:61WUA\,A
M.1/4;3 !V[(HX\PBN+%8\Q*W?F?Z+Z&#&&!.>9(@2'?PL(&\'+YZ(,@]!3=:
M_%^M1,HHJK)$%D>YB9+/1T9;47R@41=A[?K"\UH13CY?A,R'D?L-J;![&SZA
MPKT"?($ SWPZ:50BE8VW&O#";]+Y2MMY1V2.-:CTH&$S>HU+J(H3GS=:Q2YH
ME-MT >GU6NT^$8RJ08W%2;0;_M'$]50KSD'_W:]]A,>)/W5B-#1X':M'H]Z?
MOCT]_NWTY'[L'NZ;-[>+R%H$P)&U"%O6C9N 33M,=%>E;%MZ>&'3XM5=6D;)
M;#F(LZ*R\T6U;/Q3H'\.<%.;%+ME9=;YU;RYT$&SU +L2CO#B3:!C@DT//="
AFH,Q!LFU5X)T[_X4M:^,J=(972ZP11'Y"TI,2,:#"0  
 
