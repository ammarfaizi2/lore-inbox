Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262586AbTDAPH4>; Tue, 1 Apr 2003 10:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262592AbTDAPH4>; Tue, 1 Apr 2003 10:07:56 -0500
Received: from os.inf.tu-dresden.de ([141.76.48.99]:64977 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S262586AbTDAPHz>; Tue, 1 Apr 2003 10:07:55 -0500
Date: Tue, 1 Apr 2003 17:19:18 +0200
From: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: genksyms crashes on drivers/char/joystick/pcigame.c
Message-ID: <20030401151918.GJ1870@os.inf.tu-dresden.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when genksyms is used on drivers/char/joystick/pcigame.c during "make
dep" it segfaults. There isn't any joystick configuration in the kernel
(it's a plain "make oldconfig" from a fresh kernel copy).

/tmp/linux-2.4.20/drivers/char/joystick$ gcc -Wall -O2 -I/tmp/linux-2.4.20/include  -E -D__GENKSYMS__ pcigame.c| genksyms -p smp_ -k 2.4.20
Segmentation fault

$ genksyms -V       
genksyms version 2.4.25
...

It looks like the segfault is caused by the following line from the gcc
output above:

struct pcigame *((void *)0)
{
        struct pcigame *pcigame;
        int i;


which evaluates from

struct pcigame *pcigame_attach(struct pci_dev *dev, int type)
{
        struct pcigame *pcigame;
        int i;


pcigame_attach(a,b) is defined to NULL in include/linux/pci_gameport.h if
CONFIG_INPUT_PCIGAME{,_MODULE} isn't set (which is the case here).
Fixing this line makes genksyms work. Don't know who's at fault here but
segfaulting doesn't look good...




Adam
-- 
Adam                 adam@os.inf.tu-dresden.de
  Lackorzynski         http://os.inf.tu-dresden.de/~adam/
