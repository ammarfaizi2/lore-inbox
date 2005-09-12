Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbVILXJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVILXJX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 19:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVILXJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 19:09:23 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:38277 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932340AbVILXJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 19:09:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=GRdctvXFPOG6QWMJW96rMCu2lCTFINS0EX0NHFYQiCjPnrnihtEKLd8d8RMkq/GlNmcD9JN1AT1UZTSHv096JF3hFNdo4WytiTMKb+0H0fih0CapdrRPWrcTfa4Ngoz3I6Qy5J5FT0jUiPUv7hSCx0oh0fKrhkLBw6WvNSDxtEQ=
Message-ID: <43260A99.7070702@gmail.com>
Date: Tue, 13 Sep 2005 01:09:13 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.13-mm3 OOPS Reporting Tool v.b6 
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I think, that this maybe useful for oops hunters :)

Regards,
Michal Piotrowski

diff -uprN -X linux-mm-clean/Documentation/dontdiff 
linux-mm-clean/scripts/ort.sh linux-mm/scripts/ort.sh
--- linux-mm-clean/scripts/ort.sh    1970-01-01 01:00:00.000000000 +0100
+++ linux-mm/scripts/ort.sh    2005-09-13 00:59:12.000000000 +0200
@@ -0,0 +1,1087 @@
+#!/bin/sh
+
+# Copyright (C) 2005  Michał Piotrowski <piotrowskim@trex.wsi.edu.pl>
+#                    <michal.k.k.piotrowski@gmail.com>
+# Copyright (C) 2005  Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
+# Copyright (C) 2005  Paul TT <paultt@bilug.linux.it>
+# Copyright (C) 2005  Randy Dunlap <rdunlap@xenotime.net>
+# Copyright (C) 2005  Jesper Juhl <jesper.juhl@gmail.com>
+# Copyright (C) 2005  Cal Peake <cp@absolutedigital.net>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+VER=v.b6
+
+ORT_D=`date +%F`
+ORT_F=ort_oops-$ORT_D.txt
+ORT_O=$1
+
+ORT_P_COPY_D=proc_copy
+ORT_P_COPY_F=$ORT_P_COPY_D-$ORT_D.tar
+ORT_P_COPY_FC=$ORT_P_COPY_F.bz2
+
+ORT_S_COPY_D=sys_copy
+ORT_S_COPY_F=$ORT_S_COPY_D-$ORT_D.tar
+ORT_S_COPY_FC=$ORT_S_COPY_F.bz2
+
+M_EMAIL=nobody@example.org
+U_EMAIL=nobody@example.org
+LKML=linux-kernel@vger.kernel.org
+TOPIC="Automagically generated bug report (ORT)"
+
+KVER=`uname -r`
+
+help() {
+    echo "Usage: $0 oops.txt"
+    exit 1
+}
+
+yes_no() {
+    while true
+    do
+    echo -en "[Y(es)/N(o)] "
+    read REPLY
+    case $REPLY in
+        y | Y | yes | Yes | YES)
+            REPLY=1
+        break
+        ;;
+        n | N | no | No | NO)
+            REPLY=0
+        break
+        ;;
+        *)
+            echo -e "Please answer Y(es) or N(o)"
+        ;;
+    esac
+    done
+}
+
+root_notice() {
+    echo "This step requires root privileges. If you choose \"yes\" you 
will be prompted"
+    echo "for your root password. If you choose \"no\" your report 
won't be as detailed."
+    echo "Do you wish to perform with this step?"
+}
+
+cmd_line() {
+    if [[ -z "$ORT_O" || "$ORT_O" = "-h" || "$ORT_O" = "--help" ]]
+    then
+        help
+    elif [[ ! -r "$ORT_O" ]]
+    then
+        echo "ERROR: You must provide a proper file with the Oops text"
+        help
+    fi
+}
+
+rm_ortmp() {
+    rm -f ortmp.txt
+    rm -f t.txt
+    rm -f topic.txt
+}
+
+logo() {
+    clear
+    echo "OOPS Reporting Tool $VER"
+}
+
+check_which() {
+    WHICH=`which $1`
+    if [ "$WHICH" != "" ]
+    then
+        echo -e " [available]"
+    else
+        echo
+    fi
+}
+
+choose_editor() {
+    if [ ! -z "$EDITOR" ]
+    then
+        return
+    fi
+    while true
+    do
+    echo -e "\nChoose your favourite text editor:"
+    echo -e -n "1 - vim"
+    check_which vim
+    echo -e -n "2 - emacs"
+    check_which emacs
+    echo -e -n "3 - mcedit"
+    check_which mcedit
+    echo -e -n "4 - vi"
+    check_which vi
+    echo -e -n "5 - elvis"
+    check_which elvis
+    echo -e -n "6 - joe"
+    check_which joe
+    echo -e -n "7 - jove"
+    check_which jove
+    echo -e -n "8 - nano"
+    check_which nano
+    echo -e -n "9 - pico"
+    check_which pico
+    echo -e "o - other"
+    echo -en ": "
+    read TXT
+    case "$TXT" in
+    1 )
+        EDITOR=vim
+        break
+        ;;
+    2 )
+        EDITOR=emacs
+        break
+        ;;
+    3 )
+        EDITOR=mcedit
+        break
+        ;;
+    4 )
+        EDITOR=vi
+        break
+        ;;
+    5 )
+        EDITOR=elvis
+        break
+        ;;
+    6 )
+        EDITOR=joe
+        break
+        ;;
+    7 )
+        EDITOR=jove
+        break
+        ;;
+    8 )
+        EDITOR=nano
+        break
+        ;;
+    9 )
+        EDITOR=pico
+        break
+        ;;
+    o | O )
+        while true
+        do
+                echo -en "\nWrite editor name: "
+            read EDITOR
+            echo -e "You wrote < $EDITOR > is this correct?"
+            yes_no
+            if [ $REPLY = 1 ]
+                then
+                break
+            fi
+        done
+        break
+        ;;
+    esac
+    done
+}
+
+choose_pager() {
+    if [ ! -z "$PAGER" ]
+    then
+        return
+    fi
+    while true
+    do
+    echo -e "\nChoose your favourite pager:"
+    echo -e -n "1 - less"
+    check_which less
+    echo -e -n "2 - more"
+    check_which more
+    echo -e -n "3 - most"
+    check_which most
+    echo -e "o - other"
+    echo -en ": "
+    read TXT
+    case "$TXT" in
+    1 )
+        PAGER=less
+        break
+        ;;
+    2 )
+        PAGER=more
+        break
+        ;;
+    3 )
+        PAGER=most
+        break
+        ;;
+    o | O )
+        while true
+        do
+                echo -en "\nWrite pager name: "
+            read PAGER
+            echo -e "You wrote < $PAGER > is this correct?"
+            yes_no
+            if [ $REPLY = 1 ]
+                then
+                break
+            fi
+        done
+        break
+        ;;
+    esac
+    done
+}
+
+choose_em_cli() {
+    while true
+    do
+    echo -e "\nChoose your favourite (and configured) email client:"
+    echo -e -n "1 - mutt"
+    check_which mutt
+    echo -e -n "2 - pine"
+    check_which pine
+    echo -e -n "3 - nail"
+    check_which nail
+    echo -e -n "4 - sendmail"
+    check_which sendmail
+    echo -e "o - other"
+    echo -en ": "
+    read TXT
+    case "$TXT" in
+    1 )
+        MUA=send_mutt
+        break
+        ;;
+    2 )
+        MUA=send_pine
+        break
+        ;;
+    3 )
+        MUA=send_nail
+        break
+        ;;
+    4 )
+        MUA=send_sendmail
+        break
+        ;;
+    o | O )
+        while true
+        do
+                echo -en "\nWrite email client name: "
+            read EM_CLI
+            echo -e "You wrote < $EM_CLI > is this correct?"
+            yes_no
+            if [ $REPLY = 1 ]
+                then
+                break
+            fi
+            done
+        break
+        ;;
+    esac
+    done
+}
+
+txt_read() {
+    while true
+    do
+    read TXT
+    if [ "$TXT" == "." ]
+        then
+        break
+    fi
+    echo "$TXT" >> $ORT_F
+    done
+}
+
+txt_read_ed() {
+    read TXT
+    echo $TXT > ortmp.txt
+    $EDITOR ortmp.txt
+    cat ortmp.txt >> $ORT_F
+}
+
+point_1() {
+    echo -e "\n[1.] One or more line summary of the problem: (end with 
a line containing only a '.')"
+    echo -e "\n[1.] One line summary of the problem:" > $ORT_F
+    txt_read
+}
+
+point_2() {
+    echo "[2.] Full description of the problem/report: (end with a line 
containing only a '.')"
+    echo -e "\n[2.] Full description of the problem/report:" >> $ORT_F
+    txt_read
+}
+
+point_3() {
+    echo "[3.] Keywords (i.e., modules, networking, kernel): (press 
Return to continue)"
+    echo -e "\n[3.] Keywords (i.e., modules, networking, kernel):" >> 
$ORT_F
+    txt_read_ed
+    cp ortmp.txt topic.txt
+}
+
+point_4() {
+    echo -e "\n[4.] Kernel version (from /proc/version):"
+    echo -e "\n[4.] Kernel version (from /proc/version):" >> $ORT_F
+    cat /proc/version >> $ORT_F
+}
+
+point_5() {
+    echo -e "\n[5.] Output of Oops"
+    echo -e "\n[5.] Output of Oops" >> $ORT_F
+    cat $ORT_O >> $ORT_F
+    TAINTED=`cat $ORT_O | grep "Tainted:"`
+    NULL="t.txt";
+    if [ "$TAINTED" > "$NULL" ]
+    then
+        echo "Tainted kernel!!!"
+        echo "Please reproduce with an untainted kernel before you send 
the report to LKML."
+        echo "This script will not allow you to send a report for a 
tainted kernel."
+        LKML=banned@banned.org
+    fi
+}
+
+point_6() {
+    echo -e "\n[6.] A small shell script or example program which 
triggers the problem (if possible): (end with a line containing only a '.')"
+    echo -e "\n\n[6.] A small shell script or example program which 
triggers the problem (if possible):" >> $ORT_F
+    txt_read
+}
+
+point_7_1() {
+    echo -e "\n[7.] Environment"
+    echo -e "\n[7.] Environment" >> $ORT_F
+    echo -e "\n[7.1.] Software" >> $ORT_F
+    /lib/modules/$KVER/build/scripts/ver_linux >> $ORT_F
+}
+
+point_7_2() {
+    echo -e "\n[7.2.] Processor information" >> $ORT_F
+    cat /proc/cpuinfo >> $ORT_F
+}
+
+point_7_3() {
+    echo -e "\n[7.3.] Module information" >> $ORT_F
+    cat /proc/modules >> $ORT_F
+}
+
+point_7_4() {
+    echo -e "\n[7.4.] Loaded driver and hardware information" >> $ORT_F
+    cat /proc/ioports >> $ORT_F
+    cat /proc/iomem >> $ORT_F
+}
+
+point_7_5() {
+    echo -e "\n[7.5.] PCI information"
+    echo -e "\n[7.5.] PCI information" >> $ORT_F
+    root_notice
+    yes_no
+    if [ $REPLY = 1 ]
+    then
+        su -c "lspci -vvv >> $ORT_F"
+    else
+        /sbin/lspci >> $ORT_F
+    fi
+}
+
+point_7_6() {
+    if [ -f /proc/scsi/scsi ]; then
+    echo -e "\n[7.6.] SCSI information" >> $ORT_F
+    cat /proc/scsi/scsi >> $ORT_F
+    fi
+}
+
+point_7_7() {
+    echo -e "\n[7.7.] USB information"
+    echo -e "\n[7.7.] USB information" >> $ORT_F
+    root_notice
+    yes_no
+    if [ $REPLY = 1 ]
+    then
+        su -c "lsusb -v >> $ORT_F"
+    else
+        /sbin/lsusb >> $ORT_F
+    fi
+}
+
+point_7_8() {
+    echo -e "\n[7.8.] dmesg log" >> $ORT_F
+    dmesg -s 100000 >> $ORT_F
+}
+
+point_7_9() {
+    echo -e "\n[7.9.] /proc copy"
+    echo -e "\nDo you want to create a copy of /proc ?"
+    yes_no
+    if [ $REPLY = 0 ]
+    then
+        return
+    fi
+    if [ -d $ORT_P_COPY_D ]
+    then
+        rm -rf $ORT_P_COPY_D
+    fi
+    if [ -f $ORT_P_COPY_F ]
+    then
+        rm $ORT_P_COPY_F
+    fi
+    if [ -f $ORT_P_COPY_FC ]
+    then
+        rm $ORT_P_COPY_FC
+    fi
+    mkdir -p $ORT_P_COPY_D
+#    cp -R /proc/acpi $ORT_P_COPY_D &>/dev/null
+    cp -R /proc/asound $ORT_P_COPY_D &>/dev/null
+    cp -R /proc/bus $ORT_P_COPY_D &>/dev/null
+    cp -R /proc/driver $ORT_P_COPY_D &>/dev/null
+    cp -R /proc/fs $ORT_P_COPY_D &>/dev/null
+    cp -R /proc/ide $ORT_P_COPY_D &>/dev/null
+    cp -R /proc/irq $ORT_P_COPY_D &>/dev/null
+    cp -R /proc/net $ORT_P_COPY_D &>/dev/null
+    cp -R /proc/scsi $ORT_P_COPY_D &>/dev/null
+    cp -R /proc/sys/debug $ORT_P_COPY_D/sys &>/dev/null
+    cp -R /proc/sys/dev $ORT_P_COPY_D/sys &>/dev/null
+    cp -R /proc/sys/fs $ORT_P_COPY_D/sys &>/dev/null
+    cp -R /proc/sys/kernel $ORT_P_COPY_D/sys &>/dev/null
+    cp -R /proc/sys/proc $ORT_P_COPY_D/sys &>/dev/null
+    cp -R /proc/sys/vm $ORT_P_COPY_D/sys &>/dev/null
+    cp -R /proc/sysvipc $ORT_P_COPY_D &>/dev/null
+    cp -R /proc/tty $ORT_P_COPY_D &>/dev/null
+    cp /proc/buddyinfo $ORT_P_COPY_D &>/dev/null
+    cp /proc/cmdline $ORT_P_COPY_D &>/dev/null
+    cp /proc/config.gz $ORT_P_COPY_D &>/dev/null
+    cp /proc/cpuinfo $ORT_P_COPY_D &>/dev/null
+    cp /proc/crypto $ORT_P_COPY_D &>/dev/null
+    cp /proc/devices $ORT_P_COPY_D &>/dev/null
+    cp /proc/diskstats $ORT_P_COPY_D &>/dev/null
+    cp /proc/dma $ORT_P_COPY_D &>/dev/null
+    cp /proc/execdomains $ORT_P_COPY_D &>/dev/null
+    cp /proc/filesystems $ORT_P_COPY_D &>/dev/null
+    cp /proc/interrupts $ORT_P_COPY_D &>/dev/null
+    cp /proc/iomem $ORT_P_COPY_D &>/dev/null
+    cp /proc/ioports $ORT_P_COPY_D &>/dev/null
+    cp /proc/kallsyms $ORT_P_COPY_D &>/dev/null
+    cp /proc/key-users $ORT_P_COPY_D &>/dev/null
+    cp /proc/keys $ORT_P_COPY_D &>/dev/null
+    cp /proc/loadavg $ORT_P_COPY_D &>/dev/null
+    cp /proc/locks $ORT_P_COPY_D &>/dev/null
+    cp /proc/meminfo $ORT_P_COPY_D &>/dev/null
+    cp /proc/misc $ORT_P_COPY_D &>/dev/null
+    cp /proc/modules $ORT_P_COPY_D &>/dev/null
+    cp /proc/mounts $ORT_P_COPY_D &>/dev/null
+    cp /proc/mtrr $ORT_P_COPY_D &>/dev/null
+    cp /proc/partitions $ORT_P_COPY_D &>/dev/null
+    cp /proc/pci $ORT_P_COPY_D &>/dev/null
+    cp /proc/schedstat $ORT_P_COPY_D &>/dev/null
+    cp /proc/slabinfo $ORT_P_COPY_D &>/dev/null
+    cp /proc/stat $ORT_P_COPY_D &>/dev/null
+    cp /proc/swaps $ORT_P_COPY_D &>/dev/null
+    cp /proc/sysrq-trigger $ORT_P_COPY_D &>/dev/null
+    cp /proc/uptime $ORT_P_COPY_D &>/dev/null
+    cp /proc/version $ORT_P_COPY_D &>/dev/null
+    cp /proc/vmstat $ORT_P_COPY_D &>/dev/null
+    tar cf $ORT_P_COPY_F $ORT_P_COPY_D
+    bzip2 -9 $ORT_P_COPY_F
+    echo "/proc copy = $ORT_P_COPY_FC"
+}
+
+point_7_10() {
+    echo -e "\n[7.10.] /sys copy"
+    echo -e "\nDo you want to create a copy of /sys ?"
+    yes_no
+    if [ $REPLY = 0 ]
+    then
+        return
+    fi
+    if [ -d $ORT_S_COPY_D ]
+    then
+        rm -rf $ORT_S_COPY_D
+    fi
+    if [ -f $ORT_S_COPY_F ]
+    then
+        rm -f $ORT_S_COPY_F
+    fi
+    if [ -f $ORT_S_COPY_FC ]
+    then
+        rm -f $ORT_S_COPY_FC
+    fi
+    mkdir -p $ORT_S_COPY_D
+    cp -R /sys/ $ORT_S_COPY_D &>/dev/null
+    tar cf $ORT_S_COPY_F $ORT_S_COPY_D
+    bzip2 -9 $ORT_S_COPY_F
+    echo "/sys copy = $ORT_S_COPY_FC"
+}
+
+point_7_11() {
+    echo -e "\n[7.11.] sysctl -A" >> $ORT_F
+    sysctl -A >> $ORT_F
+}
+
+point_8() {
+    echo -e "\n[8.] Config file"
+    echo -e "\n[8.] Config file" >> $ORT_F
+    while true
+    do
+    echo -e "\nDo you want to manually enter the path to the kernel's 
.config file?"
+    echo -en "[A(utomagic)/Y(es)/S(kip)] "
+    read TXT
+    if [ $TXT = "Y" ] || [ $TXT = "y" ]
+        then
+        echo "Enter path: (eg. /usr/src/linux-2.6)"
+        read TXT
+        if [ -r $TXT/.config ]
+            then
+                cat $TXT/.config >> $ORT_F
+            break
+            else
+                echo "ERROR: Invalid path"
+        fi
+    elif [ $TXT = "A" ] || [ $TXT = "a" ]
+        then
+        if [ -r /proc/config.gz ];
+            then
+            gzip -cd /proc/config.gz >> $ORT_F
+            break
+        elif [ -r /boot/config-$KVER ]
+            then
+            cat /boot/config-$KVER >> $ORT_F
+            break
+        elif [ -r /lib/modules/$KVER/build/.config ]
+            then
+                cat /lib/modules/$KVER/build/.config >> $ORT_F
+            break
+            else
+                echo "ERROR: Can't find kernel config file"
+            fi
+    elif [ $TXT = "S" ] || [ $TXT = "s" ]
+        then
+        break
+    fi
+    done
+}
+
+point_9() {
+    echo -e "\n[9.] Other notes, patches, fixes, workarounds: (end with 
a line containing only a '.')"
+    echo -e "\n[9.] Other notes, patches, fixes, workarounds:" >> $ORT_F
+    txt_read
+}
+
+r_type_short() {
+    point_1
+    point_2
+    point_3
+    point_4
+    point_5
+}
+
+r_type_long() {
+    r_type_short
+
+    point_6
+    point_7_1
+    point_7_2
+    point_7_3
+    point_7_4
+    point_7_5
+    point_7_6
+    point_7_7
+    point_7_8
+    point_7_9
+    point_7_10
+    point_7_11
+    point_8
+    point_9
+}
+
+r_type_custom() {
+    r_type_short
+
+    while true
+    do
+    echo -e "\n[6.] A small shell script..."
+    yes_no
+        if [ $REPLY = 1 ]
+            then
+            point_6
+        break
+        else
+        break
+        fi
+    done
+
+    while true
+    do
+    echo -e "\n[7.1.] Software..."
+    yes_no
+        if [ $REPLY = 1 ]
+            then
+            point_7_1
+        break
+        else
+        break
+        fi
+    done
+
+    while true
+    do
+    echo -e "\n[7.2.] Processor..."
+    yes_no
+        if [ $REPLY = 1 ]
+            then
+            point_7_2
+        break
+        else
+        break
+        fi
+    done
+
+    while true
+    do
+    echo -e "\n[7.3.] Module..."
+    yes_no
+        if [ $REPLY = 1 ]
+            then
+            point_7_3
+        break
+        else
+        break
+        fi
+    done
+
+    while true
+    do
+    echo -e "\n[7.4.] Loaded driver..."
+    yes_no
+        if [ $REPLY = 1 ]
+            then
+            point_7_4
+        break
+        else
+        break
+        fi
+    done
+
+    while true
+    do
+    echo -e "\n[7.5.] PCI information..."
+    yes_no
+        if [ $REPLY = 1 ]
+            then
+            point_7_5
+        break
+        else
+        break
+        fi
+    done
+
+    while true
+    do
+    echo -e "\n[7.6.] SCSI..."
+    yes_no
+        if [ $REPLY = 1 ]
+            then
+            point_7_6
+        break
+        else
+        break
+        fi
+    done
+
+    while true
+    do
+    echo -e "\n[7.7.] USB..."
+    yes_no
+        if [ $REPLY = 1 ]
+            then
+            point_7_7
+        break
+        else
+        break
+        fi
+    done
+
+    while true
+    do
+    echo -e "\n[7.8.] dmesg..."
+    yes_no
+        if [ $REPLY = 1 ]
+            then
+            point_7_8
+        break
+        else
+        break
+        fi
+    done
+
+    while true
+    do
+    echo -e "\n[7.9.] /proc copy..."
+    yes_no
+        if [ $REPLY = 1 ]
+            then
+            point_7_9
+        break
+        else
+        break
+        fi
+    done
+
+    while true
+    do
+    echo -e "\n[7.10.] /sys copy..."
+    yes_no
+        if [ $REPLY = 1 ]
+            then
+            point_7_10
+        break
+        else
+        break
+        fi
+    done
+
+    while true
+    do
+    echo -e "\n[7.11.] sysctl..."
+    yes_no
+        if [ $REPLY = 1 ]
+            then
+            point_7_11
+        break
+        else
+        break
+        fi
+    done
+
+    while true
+    do
+    echo -e "\n[8.] Config..."
+    yes_no
+        if [ $REPLY = 1 ]
+            then
+            point_8
+        break
+        else
+        break
+        fi
+    done
+
+    while true
+    do
+    echo -e "\n[9.] Other notes..."
+    yes_no
+        if [ $REPLY = 1 ]
+            then
+            point_9
+        break
+        else
+        break
+        fi
+    done
+}
+
+r_type_template_pci() {
+    r_type_short
+
+    point_7_1
+    point_7_3
+    point_7_4
+    point_7_5
+}
+
+r_type_template_usb() {
+    r_type_short
+
+    point_7_1
+    point_7_3
+    point_7_4
+    point_7_7
+}
+
+r_type_template() {
+    while true
+    do
+    echo -e "\nChoose template"
+    echo -e "1 - PCI"
+    echo -e "2 - USB"
+    read TXT
+    case "$TXT" in
+        1 )
+        r_type_template_pci
+        break
+        ;;
+        2 )
+        r_type_template_usb
+        break
+        ;;
+        * )
+        ;;
+    esac
+    done
+}
+
+choose_r_type() {
+    while true
+    do
+        echo -e "\nChoose report type"
+    echo -e "(S)hort/(L)ong/(C)ustom/(T)emplate"
+        read TXT
+    case "$TXT" in
+        s | S )
+        r_type_short       
+        break
+        ;;
+        l | L )
+        r_type_long       
+        break
+        ;;
+        c | C )
+        r_type_custom
+        break
+        ;;
+        t | T )
+        r_type_template
+        break
+        ;;
+        * )
+        ;;
+        esac
+    done
+}
+
+ort_sig() {
+    cat << EOF >> $ORT_F
+
+
+OOPS Reporting Tool $VER
+www.wsi.edu.pl/~piotrowskim/
+/files/ort/beta/
+EOF
+}
+
+less_r() {
+    echo -e "\nDo you want to see $ORT_F?"
+    yes_no
+    if [ $REPLY = 1 ]
+    then
+        $PAGER $ORT_F
+    fi
+}
+
+edit_r() {
+    echo -e "\nDo you want to edit $ORT_F in $EDITOR?"
+    yes_no
+    if [ $REPLY = 1 ]
+    then
+        $EDITOR $ORT_F
+    fi
+}
+
+get_m_email() {
+    echo -e "\nDo you want to list the MAINTAINERS file to locate the 
proper maintainer?"
+    yes_no
+    if [ $REPLY = 1 ]
+    then
+        if [ -f /lib/modules/$KVER/build/MAINTAINERS ]
+        then
+            $PAGER /lib/modules/$KVER/build/MAINTAINERS
+        else
+            echo "ERROR: Can't find MAINTAINERS file"
+        fi
+    fi
+
+    while true
+    do
+    echo -en "\nWrite maintainer e-mail: "
+    read M_EMAIL
+    echo -e "You wrote < $M_EMAIL > is this correct?"
+    yes_no
+    if [ $REPLY = 1 ]
+        then
+        break
+    fi
+    done
+}
+
+get_u_email() {
+    while true
+    do
+    echo -e "\nWrite your e-mail (to be used as from address)"
+    echo -e "Please make sure it's correct so people can get back to you."
+    echo -en ": "
+    read U_EMAIL
+    echo -e "You wrote < $U_EMAIL > is this correct?"
+    yes_no
+    if [ $REPLY = 1 ]
+        then
+        break
+    fi
+    done
+}
+
+# send_MUA(subject, body, recipient[, recipient ...])
+
+send_mutt() {
+    if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]
+        then
+        echo "Failed"
+        return
+    fi
+
+    SUBJ="$1"
+    shift
+    BODY="$1"
+    shift
+
+    while [ ! -z "$1" ]
+    do
+        RCPTS="$RCPTS $1"
+        shift
+    done
+
+    # XXX: this needs to be tested
+    mutt -s "$SUBJ" -i $BODY $RCPTS
+}
+
+send_pine() {
+    if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]
+        then
+        echo "Failed"
+        return
+    fi
+
+    SUBJ="$1"
+    shift
+    BODY="$1"
+    shift
+
+    while [ ! -z "$1" ]
+    do
+        RCPTS="$RCPTS,$1"
+        shift
+    done
+
+    # pine can't specify the subject nor the body from the command line,
+    # we can attach however, but should we?
+    pine -attach $BODY "$RCPTS"
+}
+
+send_nail() {
+    if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]
+        then
+        echo "Failed"
+        return
+    fi
+
+    SUBJ="$1"
+    shift
+    BODY="$1"
+    shift
+
+    while [ ! -z "$1" ]
+    do
+        RCPTS="$RCPTS $1"
+        shift
+    done
+
+    # XXX: do we want to set the from for nail ?
+    #get_u_email
+    #nail -s "$SUBJ" -q $BODY -r $U_EMAIL "$RCPTS"
+
+    nail -s "$SUBJ" -q $BODY "$RCPTS"
+}
+
+send_sendmail() {
+    if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]
+        then
+        echo "Failed"
+        return
+    fi
+
+    SUBJ="$1"
+    shift
+    BODY="$1"
+    shift
+
+    while [ ! -z "$1" ]
+    do
+        TO="$TO,$1"
+        RCPTS="$RCPTS $1"
+        shift
+    done
+
+    get_u_email
+    echo -e "To:${TO}\nSubject: ${SUBJ}\n`cat ${ORT_F}`\n" | sendmail 
-f $U_EMAIL $RCPTS
+}
+
+send_custom() {
+    # XXX: untested but this should work for a number of mail clients
+    $EM_CLI "mailto:${RCPTS}?subject=${SUBJ}&body=`cat ${BODY}`"
+}
+
+send_r() {
+    while true
+    do
+    echo -e "\nDo you want to send $ORT_F ?"
+    yes_no
+    if [ $REPLY = 0 ]
+        then
+        echo -e "\nPlease email $ORT_F to $LKML"
+        echo -e "or some other appropriate Linux mailing list."
+        break
+    fi
+    if [ ! -z "$EM_CLI" ]
+        then
+        MUA=send_custom
+    fi
+    while true
+    do
+        echo -e "1 - send to LKML"
+        echo -e "2 - send to maintainer"
+        echo -e "3 - send to maintainer and LKML"
+        read TXT_1
+        case "$TXT_1" in
+        1 )
+        $MUA "[OOPS] $TOPIC" $ORT_F $LKML
+        break
+        ;;
+        2 )
+        get_m_email
+        $MUA "[OOPS] $TOPIC" $ORT_F $M_EMAIL
+        break
+        ;;
+        3 )
+        get_m_email
+        $MUA "[OOPS] $TOPIC" $ORT_F $LKML $M_EMAIL
+        break
+        ;;
+        esac
+    done
+    break
+    done
+    echo -e "And please, use this informations to file a BUG in the 
kernel Bugzilla you'll"
+    echo -e "find at bugme.osdl.org.\nThanks\n"
+}
+
+cmd_line
+rm_ortmp
+logo
+
+choose_editor
+choose_pager
+choose_em_cli
+
+choose_r_type
+
+ort_sig
+
+less_r
+edit_r
+send_r
+
+rm_ortmp

