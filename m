Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135937AbREGGem>; Mon, 7 May 2001 02:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135939AbREGGed>; Mon, 7 May 2001 02:34:33 -0400
Received: from voyager.powersurfr.com ([24.109.67.8]:20487 "EHLO
	unity.starfire") by vger.kernel.org with ESMTP id <S135937AbREGGeQ>;
	Mon, 7 May 2001 02:34:16 -0400
From: Maciek Nowacki <maciek@Voyager.powersurfr.com>
Date: Mon, 7 May 2001 00:34:13 -0600
To: linux-kernel@vger.kernel.org
Subject: scripts/Configure patch for automatic module compile
Message-ID: <20010507003413.A28246@megabyte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If you're like me, you build everything as modules, boot with an initrd that
loads in the disk or net driver and filesystem module, and then let kmod take
care of the rest. Here's a patch that changes Configure (make config) to
build all possible modules - in other words, to answer 'M' for every tristate
of some form y/m/n. It also allows some tristates to be built into the
kernel (y), so you can have a root filesystem and executables. This is done
by changing tristates in arch/${ARCH}/defconfig to default to 'a'. For
instance:

CONFIG_BINFMT_ELF=a
CONFIG_BLK_DEV_RAM=a
CONFIG_CRAMFS=a

I am posting the patch in the hope that someone finds it useful or uses it
perhaps as inspiration for a better solution. Eventually, I'd like to cut
down the config process to a short list of questions about CPU, bus, network,
and then get all the modules automatically.

Caveats: hmm.. well, it's only tested on i386, though I don't see why it
wouldn't work on anything else. If you're not running some kind of embedded
system, the defconfig must be changed or the kernel won't be very useful. Of
course, this only works with 'make config' - 'menuconfig' and 'xconfig' are
unchanged.

Maciek


--- Configure.old	Sun May  6 22:28:07 2001
+++ Configure	Mon May  7 00:07:32 2001
@@ -155,6 +155,7 @@
 
 	 "m")
 		echo "$1=m" >>$CONFIG
+		echo "$1=m"
 		echo "#undef  $1" >>$CONFIG_H
 		echo "#define $1_MODULE 1" >>$CONFIG_H
 		;;
@@ -207,26 +208,11 @@
 	  old=$(eval echo "\${$2}")
 	  def=${old:-'n'}
 	  case "$def" in
-	   "y") defprompt="Y/m/n/?"
+	   "a") define_tristate "$2" "y"
 		;;
-	   "m") defprompt="M/n/y/?"
-		;;
-	   "n") defprompt="N/y/m/?"
+	   * ) define_tristate "$2" "m"
 		;;
 	  esac
-	  while :; do
-	    readln "$1 ($2) [$defprompt] " "$def" "$old"
-	    case "$ans" in
-	      [yY] | [yY]es ) define_tristate "$2" "y"
-			      break ;;
-	      [nN] | [nN]o )  define_tristate "$2" "n"
-			      break ;;
-	      [mM] )          define_tristate "$2" "m"
-			      break ;;
-	      * )             help "$2"
-			      ;;
-	    esac
-	  done
 	fi
 }
 
@@ -269,25 +255,7 @@
 		 "n") defprompt="N/m/?"
 		      ;;
 		esac
-		while :; do
-		  readln "$ques ($var) [$defprompt] " "$def" "$old"
-		  case "$ans" in
-		      [nN] | [nN]o )  define_tristate "$var" "n"
-				      break ;;
-		      [mM] )          define_tristate "$var" "m"
-				      break ;;
-		      [yY] | [yY]es ) echo 
-   echo "  This answer is not allowed, because it is not consistent with"
-   echo "  your other choices."
-   echo "  This driver depends on another one which you chose to compile"
-   echo "  as a module. This means that you can either compile this one"
-   echo "  as a module as well (with M) or leave it out altogether (N)."
-				      echo
-				      ;;
-		      * )             help "$var"
-				      ;;
-		  esac
-		done
+		define_tristate "$var" "m"
 	   fi
 	else
 	   tristate "$ques" "$var"
