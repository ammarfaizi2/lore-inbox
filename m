Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbSK1TJb>; Thu, 28 Nov 2002 14:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266712AbSK1TJb>; Thu, 28 Nov 2002 14:09:31 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:18655 "EHLO
	postfix2-2.free.fr") by vger.kernel.org with ESMTP
	id <S263137AbSK1TJ2>; Thu, 28 Nov 2002 14:09:28 -0500
Date: Thu, 28 Nov 2002 20:17:34 +0100
From: Romain Lievin <rlievin@free.fr>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: kconfig (gkc): help about Makefile
Message-ID: <20021128191734.GA476@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

I'm currently working on the kernel Makefile ($SRC & $SRC/scripts/kconfig)
for adding gkc support but I'm encountering some difficulties...
I have written a standalone Makefile for the gkc package which I'm integrating
into the kernel's Makefile.

I does not understand why it does not run the GTK detection (l75 in the
Makefile). I hope that I am not bothering you but I'm not a guru in this
kind of Makefile: it's too elaborated for me.

==========================[ kernel Makefile ]========================
#################
#
# Shared Makefile for the various lkc executables:
# conf:	  Used for defconfig, oldconfig and related targets
# mconf:  Used for the mconfig target.
#         Utilizes the lxdialog package
# qconf:  Used for the xconfig target
#         Based on QT which needs to be installed to compile it
# gconf:  Used for the gconfig target
#	  Based on GTK which needs to be installed to compile it
#

TEST1=`pkg-config gtk+-2.0 --exists`
TEST2=`pkg-config gmodule-2.0 --exists`
TEST3=`pkg-config libglade-2.0 --exists`

# object files used by all lkc flavours
libkconfig-objs := zconf.tab.o

host-progs	:= conf mconf qconf gconf
conf-objs	:= conf.o  libkconfig.so
mconf-objs	:= mconf.o libkconfig.so

qconf-objs	:= kconfig_load.o
qconf-cxxobjs	:= qconf.o

gconf-objs	:= kconfig_load.o
gconf-cobjs	:= gconf.o

clean-files	:= libkconfig.so lkc_defs.h qconf.moc .tmp_qtcheck \
		   zconf.tab.c zconf.tab.h lex.zconf.c .tmp_gtkcheck \

include $(TOPDIR)/Rules.make

# generated files seem to need this to find local include files

HOSTCFLAGS_lex.zconf.o	:= -I$(src)
HOSTCFLAGS_zconf.tab.o	:= -I$(src)

HOSTLOADLIBES_qconf	= -L$(QTDIR)/lib -Wl,-rpath,$(QTDIR)/lib -l$(QTLIB) -ldl
HOSTCXXFLAGS_qconf.o	= -I$(QTDIR)/include 

HOSTLOADLIBES_gconf	= -L$(GTK_LIBS)
HOSTCXXFLAGS_gconf.o	= -I$(GTK_FLAGS)

$(obj)/conf.o $(obj)/mconf.o $(obj)/qconf.o $(obj)/gconf.o: $(obj)/zconf.tab.h

$(obj)/qconf.o: $(obj)/.tmp_qtcheck

ifeq ($(MAKECMDGOALS),$(obj)/qconf)
-include $(obj)/.tmp_qtcheck

# QT needs some extra effort...
$(obj)/.tmp_qtcheck:
	echo "Checking QT install...";
	@set -e; for d in $$QTDIR /usr/share/qt /usr/lib/qt3; do \
	  if [ -x $$d/bin/moc ]; then DIR=$$d; break; fi; \
	done; \
	if [ -z "$$DIR" ]; then \
	  echo "*"; \
	  echo "* Unable to find the QT installation. Please make sure that the"; \
	  echo "* QT development package is correctly installed and the QTDIR"; \
	  echo "* environment variable is set to the correct location."; \
	  echo "*"; \
	  false; \
	fi; \
	LIB=qt; \
	if [ -f $$DIR/lib/libqt-mt.so ]; then LIB=qt-mt; fi; \
	echo "QTDIR=$$DIR" > $@; echo "QTLIB=$$LIB" >> $@
endif

$(obj)/gconf.o: $(obj)/.tmp_gtkcheck

ifeq ($(MAKECMDGOALS),$(obj)/gconf)
-include $(obj)/.tmp_gtkcheck

# GTK needs some extra effort, too...
$(obj)/.tmp_qtcheck:
	echo "Checking GTK install...";
	@if [ $(TEST1) -a $(TEST2) -a $(TEST3) ] ;					\
	then										\
		echo "*"; 								\
		echo "* Unable to find the GTK+ installation. Please make"; 		\
		echo "* sure that the GTK+ 2.0 development package is"; 		\
		echo "* correctly installed."; 						\
		echo "* You need gtk+-2.0, gmodule-2.0 and libglade-2.0..."; 		\
		echo "*"; 								\
	else										\
		GTK_FLAGS=`pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --cflags` ;	\
		GTK_LIBS=`pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --libs`	;	\
		echo $$GTK_FLAGS $$GTK_LIBS > .tmp_gtkcheck ;				\
	fi
endif

$(obj)/zconf.tab.o: $(obj)/lex.zconf.c

$(obj)/kconfig_load.o: $(obj)/lkc_defs.h

$(obj)/qconf.o: $(obj)/qconf.moc $(obj)/lkc_defs.h

$(obj)/gconf.o: $(obj)/lkc_defs.h

$(obj)/%.moc: $(src)/%.h
	$(QTDIR)/bin/moc -i $< -o $@

$(obj)/lkc_defs.h: $(src)/lkc_proto.h
	sed < $< > $@ 's/P(\([^,]*\),.*/#define \1 (\*\1_p)/'


###
# The following requires flex/bison
# By default we use the _shipped versions, uncomment the following line if
# you are modifying the flex/bison src.
# LKC_GENPARSER := 1

ifdef LKC_GENPARSER

$(obj)/zconf.tab.c: $(obj)/zconf.y 
$(obj)/zconf.tab.h: $(obj)/zconf.tab.c

%.tab.c: %.y
	bison -t -d -v -b $* -p $(notdir $*) $<

lex.%.c: %.l
	flex -P$(notdir $*) -o$@ $<

endif
==========================[ own Makefile ]========================
#
# Simple makefile
#

VERSION = 0.96b

CC      = gcc
KERNEL  = /usr/src/linux
INSTALL = cp
RM      = rm -f

TEST1=`pkg-config gtk+-2.0 --exists`
TEST2=`pkg-config gmodule-2.0 --exists`
TEST3=`pkg-config libglade-2.0 --exists`

gkc: .tmp_gtkcheck gconf.o

gconf.o: gconf.c
	$(CC) `cat .tmp_gtkcheck` \
	-I$(KERNEL)/scripts/kconfig -L$(KERNEL)/scripts/kconfig -lkconfig \
	gconf.c -o gkc

install: patch gkc gkc.glade
	@if [ "${USER}" = "root" ]; then \
		ldconfig                $(KERNEL)/scripts/kconfig ;	\
	fi
	$(INSTALL) gkc       $(KERNEL)/scripts/kconfig
	$(INSTALL) gkc.glade $(KERNEL)/scripts/kconfig

uninstall:
	$(RM) $(KERNEL)/scripts/kconfig/gkc
	$(RM) $(KERNEL)/scripts/kconfig/gkc.glade

patch:
	@grep gconfig $(KERNEL)/Makefile > /tmp/scan;		\
	if [ ! -s /tmp/scan ] ; 				\
	then							\
		echo "Applying patch...";			\
		LKCSRC=$$PWD; export LKCSRC; 			\
		cd $(KERNEL);					\
		patch -p0 -N < $$LKCSRC/prepare.diff;		\
		echo "Done.";					\
	fi

clean: 
	rm -f *.o gkc null .tmp_gtkcheck

check: .tmp_gtkcheck
.tmp_gtkcheck:
	@if [ $(TEST1) -a $(TEST2) -a $(TEST3) ] ;					\
	then										\
		echo "*"; 								\
		echo "* Unable to find the GTK+ installation. Please make"; 		\
		echo "* sure that the GTK+ 2.0 development package is"; 		\
		echo "* correctly installed."; 						\
		echo "* You need gtk+-2.0, gmodule-2.0 and libglade-2.0..."; 		\
		echo "*"; 								\
	else										\
		GTK_FLAGS=`pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --cflags` ;	\
		GTK_LIBS=`pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --libs`	;	\
		echo $$GTK_FLAGS $$GTK_LIBS > .tmp_gtkcheck ;				\
	fi

dist: clean
	mkdir /tmp/gkc-$(VERSION) ; cp -rL * /tmp/gkc-$(VERSION)
	cd /tmp ; tar cvf - gkc-$(VERSION) | \
	gzip > gkc-$(VERSION).tar.gz
==========================[ end ]========================


Thanks, Romain.
-- 
Romain Lievin, aka 'roms'  	<roms@lpg.ticalc.org>
Web site 			<http://lpg.ticalc.org/prj_tilp>
"Linux, y'a moins bien mais c'est plus cher !"














