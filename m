Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288962AbSANUsc>; Mon, 14 Jan 2002 15:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289021AbSANUsR>; Mon, 14 Jan 2002 15:48:17 -0500
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:14859 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S289013AbSANUsC>;
	Mon, 14 Jan 2002 15:48:02 -0500
Message-ID: <3C43447D.9000504@thock.com>
Date: Mon, 14 Jan 2002 14:50:05 -0600
From: Dylan Griffiths <dylang@thock.com>
Reply-To: dylang+kernel@thock.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020111
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.4 NFS bug (annoying sylmlinx breakage)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I've noticed this bug before.  Between two hosts on a 100Mbps switched lan, 
symlinks are trashed into garbage.  Based on the output. I'm guessing a 
string loses its null somewhere.

Client is 2.4.14.  Server is 2.4.10.  Server has RAID 5 IDE softraid and 
an hpt370 driver patch provided by Tim Hockin to fix the deadlocks and 
oopsies of the hpt366 driver on my hpt370.

Both are configured with NFSv3 client and server support.  Both use Intel 
EEPro 100s.

I've been working on Mozilla again lately, but I don't have enough free HD 
space sitting on my main workstation to build on.  Luckily I have a large 
NFS home directory.  However, after configure has been run, most of the 
symlinks are mangled:

dylang@shadowgate:/builds/mozilla$ ls -l /builds/mozilla/dist/include/nspr
total 12
drwxr-xr-x    2 dylang   web          4096 Jan 14 14:24 md/
lrwxrwxrwx    1 dylang   web          1184 Jan 14 14:24 nspr.h -> 
../../../nsprpub/pr/include/./nspr.h\ 
$(MOD_DEPTH)/config/autoconf.mk\n\nHEADERS\ \=\ $(wildcard\ 
$(srcdir)/\*.h)\nCONFIGS\ \=\ $(wildcard\ $(srcdir)/\*.cfg)\n\ninclude\ 
$(topsrcdir)/config/rules.mk\n\nexport::\ $(MDCPUCFG_H)\n\t$(INSTALL)\ -m\ 
444\ $(srcdir)/$(MDCPUCFG_H)\ $(dist_includedir)\n\t$(INSTALL)\ -m\ 444\ 
$(CONFIGS)\ $(HEADERS)\ $(dist_includedir)/md\nifneq\ 
($(OS_ARCH),OpenVMS)\n\tmv\ -f\ $(dist_includedir)/$(MDCPUCFG_H)\ 
$(dist_includedir)/prcpucfg.h\nelse\n#\ mv'ing\ a\ link\ causes\ the\ 
file\ itself\ to\ move,\ not\ the\ link.\n\trm\ -f\ 
$(dist_includedir)/$(MDCPUCFG_H)\n\trm\ -f\ 
$(dist_includedir)/prcpucfg.h\n\tln\ -fs\ $(srcdir)/$(MDCPUCFG_H)\ 
$(dist_includedir)/prcpucfg.h\nendif\n\nreal_install::\n\t$(NSINSTALL)\ 
-D\ $(DESTDIR)$(includedir)/md\n\tcp\ $(srcdir)/$(MDCPUCFG_H)\ 
$(DESTDIR)$(includedir)/prcpucfg.h\n\t$(NSINSTALL)\ -t\ -m\ 644\ 
$(CONFIG)\ $(HEADERS)\ $(DESTDIR)$(includedir)/md\n\nrelease::\ 
export\n\t\@echo\ "Copying\ machine-dependent\ prcpucfg.h"\n\t\@if\ test\ 
-z\ "$(BUILD_NUMBER)";\ then\ \\\n\t\techo\ "BUILD_NUMBER\ must\ be\ 
defined";\ \\\n\t\tfalse;\ \\\n\tfi\n\t\@if\ test\ !\ -d\ 
$(RELEASE_INCLUDE_DIR);\ then\ \\\n\t\trm\ -rf\ $(RELEASE_INCLUDE_DIR);\ 
\\\n\t\t$(NSINSTALL)\ -D\ $(RELEASE_INCLUDE_DIR);\\\n\tfi\n\tcp\ 
$(srcdir)/$(MDCPUCFG_H)\ $(RELEASE_INCLUDE_DIR)/prcpucfg.h\n

...

Some of them are fine:
lrwxrwxrwx    1 dylang   web            37 Jan 14 14:24 prenv.h -> 
../../../nsprpub/pr/include/./prenv.h
lrwxrwxrwx    1 dylang   web            37 Jan 14 14:24 prerr.h -> 
../../../nsprpub/pr/include/./prerr.h
lrwxrwxrwx    1 dylang   web            39 Jan 14 14:24 prerror.h -> 
../../../nsprpub/pr/include/./prerror.h
lrwxrwxrwx    1 dylang   web            38 Jan 14 14:24 prinet.h -> 
../../../nsprpub/pr/include/./prinet.h
lrwxrwxrwx    1 dylang   web            38 Jan 14 14:24 prinit.h -> 
../../../nsprpub/pr/include/./prinit.h

I figure it's a script error in the latest code.  So I go and start to 
manually fix the symlinks.  But then, as I was fixing the 4th one:

dylang@shadowgate:/builds/mozilla/dist/include/nspr$ ls -l pripcsem.h
lrwxrwxrwx    1 dylang   web            41 Jan 14 14:24 pripcsem.h -> 
../../../nsprpub/pr/include/./pripcsem.h\200
dylang@shadowgate:/builds/mozilla/dist/include/nspr$ rm pripcsem.h; ln -s 
../../../nsprpub/pr/include/./pripcsem.h

dylang@shadowgate:/builds/mozilla/dist/include/nspr$ ls -l pripcsem.h
lrwxrwxrwx    1 dylang   web           234 Jan 14 14:32 pripcsem.h -> 
../../../nsprpub/pr/include/./pripcsem.h_PC_PRIO_IO:11,_PC_SOCK_MAXBUF:12,_PC_FILESIZEBITS:13,_PC_REC_INCR_XFER_SIZE:14,_PC_REC_MAX_XFER_SIZE:15,_PC_REC_MIN_XFER_SIZE:16,_PC_REC_XFER_ALIGN:17,_PC_ALLOC_SIZE_MIN:18,_PC_SYMLINK_MAX:19,;

Aha!  NFSv3 somehow is not handling this well at all.

Suggestions?

(Note: please CC me as I'm not on the list; BCC will bounce)
-- 
     www.kuro5hin.org -- technology and culture, from the trenches.
                          -=-=-=-=-=-
Those that give up liberty to obtain safety deserve neither.
  -- Benjamin Franklin
   http://www.zdnet.com/zdnn/stories/news/0,4586,2812463,00.html
   http://slashdot.org/article.pl?sid=01/09/16/1647231
                          -=-=-=-=-=-

