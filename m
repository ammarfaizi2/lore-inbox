Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270723AbRHKFHV>; Sat, 11 Aug 2001 01:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270724AbRHKFHL>; Sat, 11 Aug 2001 01:07:11 -0400
Received: from mtiwmhc21.worldnet.att.net ([204.127.131.46]:64654 "EHLO
	mtiwmhc21.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S270723AbRHKFHF>; Sat, 11 Aug 2001 01:07:05 -0400
Message-ID: <XFMail.20010811010702.f.duncan.m.haldane@worldnet.att.net>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.5.0.Linux:20010811010702:1322=_"
Date: Sat, 11 Aug 2001 01:07:02 -0400 (EDT)
From: f.duncan.m.haldane@worldnet.att.net
To: linux-kernel@vger.kernel.org
Subject: [PATCH]; drivers/pci.c kernel-2.4.7 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format
--_=XFMail.1.5.0.Linux:20010811010702:1322=_
Content-Type: text/plain; charset=us-ascii

Here is a tested patch to pci_find_parent_resource(dev,res) in 
drivers/pci.c. (Patch is against 2.4.7; attached as tarball)  
Problem occurs in all 2.4.x kernels.


PROBLEM: when allocating resource regions for PCI device dev at boot, 
only the resources of its parent bus dev->bus are searched.

I have an nvidia AGP card on 01:00.0 which requires PCI MEM which is a
resource of the PCI bridge 00:01.0.   

bus [01] = dev->bus gets searched, but nothing is found; the card is 
not configured. 

lspci -t  shows the pci bus tree:

-[00]-+-00.0
      +-01.0-[01]---00.0
      +-07.0
      etc

SOLUTION: if bus = dev->bus has no relevant resources listed,
try bus->parent, if != NULL.  Recursively search resources of parents,
grandparents, etc. of bus.  In my case, the resource is found on [00],
and the card works.

QUESTION: Is it in general OK to allow "upstream" resource regions 
to be allocated to a device?   Maybe only dev->bus  and dev->bus->parent 
should be searched.  (My patch will keep searching all the way to the
top)

Please CC any comments to me at f.duncan.m.haldane@worldnet.att.net.

Duncan Haldane.

------------

diff -uNr linux-2.4.7/drivers/pci/pci.c linux-2.4.7-pci_patch/drivers/pci/pci.c
--- linux-2.4.7/drivers/pci/pci.c       Thu Aug  9 02:36:31 2001
+++ linux-2.4.7-pci_patch/drivers/pci/pci.c     Thu Aug  9 13:13:02 2001
@@ -202,17 +202,18 @@
  * @res: child resource record for which parent is sought
  *
  *  For given resource region of given device, return the resource
- *  region of parent bus the given region is contained in or where
- *  it should be allocated from.
+ *  region of the parent bus (or recursively of its parents) in which the given
+ *  region is contained in or where it should be allocated from.
  */
 struct resource *
 pci_find_parent_resource(const struct pci_dev *dev, struct resource *res)
 {
-       const struct pci_bus *bus = dev->bus;
+       struct pci_bus *bus = dev->bus;
        int i;
        struct resource *best = NULL;
 
-       for(i=0; i<4; i++) {
+       while (bus) {
+         for(i=0; i<4; i++) {
                struct resource *r = bus->resource[i];
                if (!r)
                        continue;
@@ -224,6 +225,10 @@
                        return r;       /* Exact match */
                if ((res->flags & IORESOURCE_PREFETCH) && !(r->flags &
IORESOURCE_PREFETCH))
                        best = r;       /* Approximating prefetchable by
non-prefetchable */
+         }
+         if (best)
+           return best;
+         bus = bus->parent;  /* If nothing found, recursively search parent */
        }
        return best;
 }




----------------------------------
E-Mail: f.duncan.m.haldane@worldnet.att.net
Date: 11-Aug-2001
Time: 00:51:42

This message was sent by XFMail
----------------------------------

--_=XFMail.1.5.0.Linux:20010811010702:1322=_
Content-Disposition: attachment; filename="pci.c-patch.tgz"
Content-Transfer-Encoding: base64
Content-Description: pci.c-patch.tgz
Content-Type: application/octet-stream; name=pci.c-patch.tgz; SizeOnDisk=834

H4sIAF67dDsAA+1W30/bMBDua/JXHC+obZrW+dF2awEVQRFIDKYOnqapShOnsZQlleMw0MT/vnPS
QkvXsoeKbcKfwL7Y5/vOd2e7MUvye9Nuus2uOfNZ0zdnnvCjVmWHIMQl3W4b+wIv+1LuOk7bclzX
RRn7jlWB9i6d2IQ8Ex4HqPA0Fdv0Xpv/TxFvyL+UAxaGu+AgFiEd192Uf9u1uk/5d6RstUmXVIDs
gvw1vPP8yxyDmV9xWKqEVsDZHeWZrIKiEnx4USfjskrW9HTTNLdb0m6iHI7zKcBHIHbP6fQcC2xC
LN0wjD+lWTZiOT38I3ZpZDAA0yZ2w+qCUfQfYDDQAeow4DTrgR+xOAAU05z7FAU/5QGEKYcfEfMj
mHmcJgJYBqgxjYRcWiyHM9SZoh/J8uopSxNIw/lEQO+YTxs4LnKegIjok65uShvPC+Y8kzwr1BaG
i2kk99NEeCyhATBUl85RPrfBBGRRmuMuJhS8OE59T6BeyNPvTd1YZZGml5iqaAl3nPMM6eIHqcFE
NtfIapKrjMKTSysGN/m13SUMXkuHTPDcF8+hw6DK/IYsCcYl/3gxV0WSTCxWSC2MK9SxaaybQamm
w0/d1NZWyR3XZXMoE2MeodjXDe01DdCYLAAprLFNKFIcwtXt5SXOIykWTpUdkj6wAxcbw6ihL4aG
UYwpVNFe+Q3wW0XQ1ik42sd15tFi6Cv7Jn3RWAjVPV6TotyrwJNC+2W9226jg+VutxsWKcodVeY1
yPtaqw7Dew9JvsvDVGSjtFZFCvMojL1pBvtwcT0afrm+HZ0Mx59Hw7Phzcl5Dfb3Ya/KtyuVLs1D
U/Idz2Y8vWdIyJIpzDgNKVJ7EwzK5AGSNDFXxtAlGaPHopWeSWO14gsWh0kO9YuhMmFFjMrK6QMg
50WIhkUkCcM0T4LGSqln1OPPx7uIwSP+rxhHB/72dfzm2PT+j4bHp5+Gu+Eo3v/OxvefWLb94vef
6ziWev/fAkW2QaSw9Mbicy+vbv00T3wvgXMvDryEwkFQfI+j8nuQZ6jfLC8pvN6mtJlQcfT+jpCC
goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCwj+DX+LT9q8AKAAA

--_=XFMail.1.5.0.Linux:20010811010702:1322=_--
End of MIME message
