Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbTJUE5U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 00:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbTJUE5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 00:57:20 -0400
Received: from fmr03.intel.com ([143.183.121.5]:10432 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262954AbTJUE5P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 00:57:15 -0400
Subject: Re: ACPI in -pre7 builds with -Os
From: Len Brown <len.brown@intel.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-2vQa3wP/UFfRe7c34ivq"
Organization: 
Message-Id: <1066712230.2908.120.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 21 Oct 2003 00:57:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2vQa3wP/UFfRe7c34ivq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2003-10-13 at 19:14, J.A. Magallon wrote: 
> Hi all...
> 
> $subject:
> 
> drivers/acpi/Makefile:
> 
> ACPI_CFLAGS := -Os
> 
> Uh ?

-0s saves us ~20% text size.

cheers,
-Len


--=-2vQa3wP/UFfRe7c34ivq
Content-Disposition: inline
Content-Description: Forwarded message - acpi code size
Content-Type: message/rfc822

Subject: acpi code size
From: Len Brown <len.brown@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, linux-acpi <linux-acpi@intel.com>
Cc: acpi-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-kj50DVF4cRqzKl2qUddF"
Organization: 
Message-Id: <1066246567.2534.43.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 15 Oct 2003 15:36:09 -0400


--=-kj50DVF4cRqzKl2qUddF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

FYI,
Building 2.4.23 with gcc -Os (as the source tree currently does) shrinks
acpi text compared to gcc -O2.  How much -0s it saves depends on the
version of gcc:


19.5% gcc version 3.2.2 20030222 (RHL 9.0)
20.6% gcc version 3.3.1 20030930 (Fedora Test3)

as measured by text size for drivers/acpi.o with all modules excluded.

cheers,
-Len

attached the script I use to measure acpi size, and the results for -O2
and -Os on gcc 3.3.1.


--=-kj50DVF4cRqzKl2qUddF
Content-Disposition: attachment; filename=report.acpi.size
Content-Type: text/plain; name=report.acpi.size; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#!/bin/bash
# summarize the size of ACPI in Linux

# ACPI kernel modules
MODULE_FILES=
#for MODULE in drivers/acpi/*.ko ; do
#	if [ -f $MODULE ] ; then
#		MODULE_FILES="$MODULE_FILES $MODULE"
#	fi
#done

MODULE_LIST="ac asus_acpi battery button fan processor thermal toshiba_acpi"
if [ "$MODULE_FILES" = "" ] ; then
	DIR=drivers/acpi
	for MODULE in $MODULE_LIST; do
		if [ -f $DIR/$MODULE.o ] ; then
			MODULE_FILES="$MODULE_FILES $DIR/$MODULE.o"
		fi
	done
fi


if [ "$MODULE_FILES" != "" ] ; then
	echo Loadable Module Sizes:
	size $MODULE_FILES
	echo
	echo Static Kernel Size:
fi

# ACPI obj files outside drivers/acpi
STATIC_FILES=
# acpi objects in base kernel
for FILE in arch/i386/kernel/acpi/built-in.o arch/i386/kernel/acpi*.o ; do
	if [ -f $FILE ] ; then
		STATIC_FILES="$STATIC_FILES $FILE"
	fi
done


# ACPI core driver
DRIVER_DIR=drivers/acpi
for DRIVER_OBJECT in acpi.o built-in.o ; do
	if [ -f $DRIVER_DIR/$DRIVER_OBJECT ] ; then
		STATIC_FILES="$STATIC_FILES $DRIVER_DIR/$DRIVER_OBJECT"
	fi
done


NUM_FILES=`echo $STATIC_FILES | wc -w`
if [ $NUM_FILES == 0 ] ; then
	echo $0: no acpi code present
elif [ $NUM_FILES == 1 ] ; then
	size $STATIC_FILES
else
	size -t $STATIC_FILES
fi


--=-kj50DVF4cRqzKl2qUddF
Content-Disposition: attachment; filename=size.23.O2
Content-Type: text/plain; name=size.23.O2; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Loadable Module Sizes:
   text	   data	    bss	    dec	    hex	filename
   1712	    212	     12	   1936	    790	drivers/acpi/ac.o
   8628	    884	     24	   9536	   2540	drivers/acpi/asus_acpi.o
   6220	    212	     12	   6444	   192c	drivers/acpi/battery.o
   2532	    212	     24	   2768	    ad0	drivers/acpi/button.o
   1423	    212	     12	   1647	    66f	drivers/acpi/fan.o
   9643	    212	    172	  10027	   272b	drivers/acpi/processor.o
   7543	    212	     16	   7771	   1e5b	drivers/acpi/thermal.o
   3451	     72	     24	   3547	    ddb	drivers/acpi/toshiba_acpi.o

Static Kernel Size:
   text	   data	    bss	    dec	    hex	filename
   3214	      8	    136	   3358	    d1e	arch/i386/kernel/acpi.o
    917	     52	      0	    969	    3c9	arch/i386/kernel/acpi_wakeup.o
 178384	   4194	   4888	 187466	  2dc4a	drivers/acpi/acpi.o
 182515	   4254	   5024	 191793	  2ed31	(TOTALS)

--=-kj50DVF4cRqzKl2qUddF
Content-Disposition: attachment; filename=size.23.Os
Content-Type: text/plain; name=size.23.Os; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Loadable Module Sizes:
   text	   data	    bss	    dec	    hex	filename
   1294	    212	     12	   1518	    5ee	drivers/acpi/ac.o
   7249	    884	     24	   8157	   1fdd	drivers/acpi/asus_acpi.o
   5297	    212	     12	   5521	   1591	drivers/acpi/battery.o
   2031	    212	     24	   2267	    8db	drivers/acpi/button.o
   1098	    212	     12	   1322	    52a	drivers/acpi/fan.o
   7905	    212	    172	   8289	   2061	drivers/acpi/processor.o
   5894	    212	     16	   6122	   17ea	drivers/acpi/thermal.o
   2669	     72	     24	   2765	    acd	drivers/acpi/toshiba_acpi.o

Static Kernel Size:
   text	   data	    bss	    dec	    hex	filename
   3214	      8	    136	   3358	    d1e	arch/i386/kernel/acpi.o
    917	     52	      0	    969	    3c9	arch/i386/kernel/acpi_wakeup.o
 141584	   4194	   4888	 150666	  24c8a	drivers/acpi/acpi.o
 145715	   4254	   5024	 154993	  25d71	(TOTALS)

--=-kj50DVF4cRqzKl2qUddF--


--=-2vQa3wP/UFfRe7c34ivq--

