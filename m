Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262688AbVFWTF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262688AbVFWTF1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 15:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbVFWTF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 15:05:27 -0400
Received: from mail.dif.dk ([193.138.115.101]:20374 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262688AbVFWSxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 14:53:35 -0400
Date: Thu, 23 Jun 2005 20:59:08 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: =?ISO-8859-2?Q?Micha=B3_Piotrowski?= <piotrowskim@trex.wsi.edu.pl>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       randy_dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: Script to help users to report a BUG
In-Reply-To: <42BAE190.20405@trex.wsi.edu.pl>
Message-ID: <Pine.LNX.4.62.0506232057150.7467@dragon.hyggekrogen.localhost>
References: <4d8e3fd30506191332264eb4ae@mail.gmail.com> 
 <4d8e3fd30506201322242d540a@mail.gmail.com>  <4d8e3fd305062205371b0a506d@mail.gmail.com>
  <42B951B4.80703@trex.wsi.edu.pl>  <4d8e3fd30506220656241e1521@mail.gmail.com>
  <42B9544E.7030007@trex.wsi.edu.pl>  <4d8e3fd305062212343d9849ee@mail.gmail.com>
  <42B9D391.4020602@trex.wsi.edu.pl>  <4d8e3fd305062300541eca2c10@mail.gmail.com>
  <42BAA5C2.7060906@trex.wsi.edu.pl> <9a8748490506231011128f7a38@mail.gmail.com>
 <42BAE190.20405@trex.wsi.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2005, [ISO-8859-2] Micha? Piotrowski wrote:

> Hi,
> 
> Here is the latest verion:
> http://stud.wsi.edu.pl/~piotrowskim/files/ort/ort-a8.tar.bz2
> 
> Changelog:
> - Randy's patch
> - Jesper's idea (Great thanks. I haven't test it yet ;))
> - Tainted kernel detection ;)
> - Some code "reorganization"
> 

Here's a small patch with a few suggested changes. I don't know if you'll 
like all the changes, but feel free to use the bits you like and drop the 
rest :-)


--- ort.sh.original	2005-06-23 20:37:07.000000000 +0200
+++ ort.sh	2005-06-23 20:55:19.000000000 +0200
@@ -4,17 +4,17 @@
 # Copyright (C) 2005  Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
 # Copyright (C) 2005  Paul TT <paultt@bilug.linux.it>
 # Copyright (C) 2005  Randy Dunlap <rdunlap@xenotime.net>
-
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation; either version 2 of the License, or
 # (at your option) any later version.
-		
+#		
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
-				
+#				
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, write to the Free Software
 # Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
@@ -23,16 +23,16 @@
 ORT_O=$1
 VER=v.a8
 
-M_EMAIL=a@b.c
-U_EMAIL=user@email
+M_EMAIL=joe.random.maintainer@somewhere.domain.example
+U_EMAIL=reporter@mylinuxbox.domain.example
 LKML=linux-kernel@vger.kernel.org
-TOPIC=ORT
+TOPIC="Automagically generated bug report (ORT)"
 
 EDITOR=vim
 EM_CLI=mutt
 
 help() {
-    echo "Usage: [root@ng02 ort]$ ./ort.sh oops.txt"
+    echo "Usage: [root@mylinuxbox ~]$ ./ort.sh oops.txt"
     echo "You need to be root to run the script"
     exit 1
 }
@@ -43,7 +43,7 @@
 	    help
     elif [[ ! -f "$ORT_O" ]]
 	then
-	    echo "ERROR: You must give proper file with Oops"
+	    echo "ERROR: You must provide a proper file with the Oops text"
 	    help
 	    exit 1
     fi
@@ -62,11 +62,11 @@
     echo "OOPS Reporting Tool $VER" > $ORT_F
 }
 
-chose_editor() {
+choose_editor() {
     END_B=0
     while [ $END_B = 0 ]
     do
-	echo -e "\nChose Your favourite text editor"
+	echo -e "\nChoose Your favourite text editor"
 	echo -e "1 - vim"
 	echo -e "2 - emacs"
 	echo -e "3 - mcedit"
@@ -91,7 +91,7 @@
 	        do
 	        	echo -e "\nWrite editor name"
 			read EDITOR
-			echo -e "You wrote < $EDITOR > is it corect?"
+			echo -e "You wrote < $EDITOR > is it correct?"
 		        echo -e "[Y(es)/N(o)]"
 			read TXT
 			if [ $TXT = "Y" ] || [ $TXT = "y" ]
@@ -107,11 +107,11 @@
     done
 }
 
-chose_em_cli() {
+choose_em_cli() {
     END_B=0
     while [ $END_B = 0 ]
     do
-	echo -e "\nChose Your favourite (and configured) email client (i haven't test it ;))"
+	echo -e "\nChoose Your favourite (and configured) email client (I have not tested it ;))"
 	echo -e "1 - mutt (it may not work)"
 	echo -e "2 - sendmail"
 	echo -e "o - other"
@@ -131,7 +131,7 @@
 	        do
 	        	echo -e "\nWrite email client name"
 			read EM_CLI
-			echo -e "You wrote < $EM_CLI > is it corect?"
+			echo -e "You wrote < $EM_CLI > is it correct?"
 		        echo -e "[Y(es)/N(o)]"
 			read TXT
 			if [ $TXT = "Y" ] || [ $TXT = "y" ]
@@ -188,7 +188,8 @@
     if [ "$TAINTED" > "$NULL" ]
 	then
 	    echo "Tainted kernel!!!"
-	    echo "You can't send it to LKML"
+	    echo "Please reproduce with an untainted kernel before you send the report to LKML."
+	    echo "This script will not allow you to send a report for a tainted kernel."
 	    LKML=banned@banned.org
     fi
 }
@@ -242,7 +243,7 @@
 }
 
 point_7_8() {
-    echo -e "\n[7.8.] Dmesg log" >> $ORT_F
+    echo -e "\n[7.8.] dmesg log" >> $ORT_F
     dmesg -s 100000 >> $ORT_F
 }
 
@@ -254,7 +255,7 @@
 #echo -e "\n[7.9.] /proc copy"
 #while [ $END = 0 ]
 #do
-#    echo -e "\nDo You want to create /proc copy?"
+#    echo -e "\nDo you want to create /proc copy?"
 #    echo -e "[Y(es)/N(o)]"
 #    read TXT
 #    if [ $TXT = "Y" ] || [ $TXT = "y" ]
@@ -278,7 +279,7 @@
 END=0
 while [ $END = 0 ]
 do
-    echo -e "\nDo You want to pass the path to kernel .config file?"
+    echo -e "\nDo you want to manually enter the path to the kernels .config file?"
     echo -e "[A(utomagic)/Y(es)/S(kip)]"
     read TXT
     if [ $TXT = "Y" ] || [ $TXT = "y" ]
@@ -327,7 +328,7 @@
     END=0
     while [ $END = 0 ]
     do
-	echo -e "\nDo You want to see $ORT_F?"
+	echo -e "\nDo you want to see $ORT_F?"
         echo -e "[Y(es)/N(o)]"
 	read TXT
         if [ $TXT = "Y" ] || [ $TXT = "y" ]
@@ -345,7 +346,7 @@
     END=0
     while [ $END = 0 ]
     do
-	echo -e "\nDo You want to edit $ORT_F in $EDITOR?"
+	echo -e "\nDo you want to edit $ORT_F in $EDITOR?"
         echo -e "[Y(es)/N(o)]"
 	read TXT
         if [ $TXT = "Y" ] || [ $TXT = "y" ]
@@ -363,7 +364,7 @@
     END_A=0
     while [ $END_A = 0 ]
     do
-	echo -e "\nDo you want to list MAINTERNERS list?"
+	echo -e "\nDo you want to list the MAINTERNERS file to locate the proper maintainer?"
         echo -e "[Y(es)/N(o)]"
 	read TXT
 	if [ $TXT = "Y" ] || [ $TXT = "y" ]
@@ -384,7 +385,7 @@
     END_A=0
     while [ $END_A = 0 ]
     do
-	echo -e "\nWrite mainterner e-mail"
+	echo -e "\nWrite maintainer e-mail"
 	read M_EMAIL
 	echo -e "You wrote < $M_EMAIL > is it corect?"
         echo -e "[Y(es)/N(o)]"
@@ -403,7 +404,8 @@
     END_A=0
     while [ $END_A = 0 ]
     do
-	echo -e "\nWrite your e-mail"
+	echo -e "\nWrite your e-mail (to be used as from address)"
+	echo -e "Please make sure it's correct so people can get back to you."
 	read U_EMAIL
 	echo -e "You wrote < $U_EMAIL > is it corect?"
         echo -e "[Y(es)/N(o)]"
@@ -422,7 +424,7 @@
     END=0
     while [ $END = 0 ]
     do
-        echo -e "\nDo You want to send $ORT_F?"
+        echo -e "\nDo you want to send $ORT_F?"
 	echo -e "[Y(es)/N(o)]"
         read TXT
 	if [ $TXT = "Y" ] || [ $TXT = "y" ]
@@ -433,8 +435,8 @@
 		while [ $END_1 = 0 ]
 	        do
 		    echo -e "1 to LKML"
-		    echo -e "2 to mainterner"
-		    echo -e "3 to mainterner and LKML"
+		    echo -e "2 to maintainer"
+		    echo -e "3 to maintainer and LKML"
 	            read TXT_1
 		    if [ $TXT_1 = "1" ]
 		        then
@@ -443,7 +445,7 @@
 				    mutt -s "[OOPS] $TOPIC" -i $ORT_F -c $LKML
 			    elif [ $EM_CLI = "sendmail" ]
 				then
-				    echo -e "Subject: Automagically generated bug report\n`cat topic.txt`\n" | sendmail -f <$U_EMAIL> $LKML
+				    echo -e "Subject: ${TOPIC}\n`cat ${ORT_F}`\n" | sendmail -f $U_EMAIL $LKML
 			    fi
 			    END_1=1
 	            elif [ $TXT_1 = "2" ]
@@ -472,17 +474,14 @@
 rm_ortmp
 logo
 
-chose_editor
-chose_em_cli
+choose_editor
+choose_em_cli
 
 point_1
 point_2
 point_3
-
 point_4
-
 point_5
-
 point_6
 
 point_7_1
@@ -496,11 +495,10 @@
 #point_7_9
 
 point_8
-
 point_9
 
 less_r
 edit_r
 send_r
 
-rm_ortmp
\ No newline at end of file
+rm_ortmp




Kind regards,

Jesper Juhl


