Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbUKDMTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbUKDMTg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 07:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbUKDMT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 07:19:29 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:57286 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262195AbUKDMP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 07:15:29 -0500
Date: Thu, 4 Nov 2004 13:15:22 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: netfilter-devel@lists.netfilter.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [BK PATCH] Fix ip_conntrack_amanda data corruption bug that breaks amanda dumps
Message-ID: <20041104121522.GA16547@merlin.emma.line.org>
Mail-Followup-To: netfilter-devel@lists.netfilter.org,
	linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=p5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can use "bk receive" to patch with this mail.

BK: Parent repository is bk://linux.bkbits.net/linux-2.5

Patch description:
ChangeSet@1.2427, 2004-11-04 13:00:54+01:00, matthias.andree@gmx.de
    Fix ip_conntrack_amanda data corruption bug that breaks amanda dumps.
  
    Fix a bug where the ip_conntrack_amanda module replaces the first LF
    after "CONNECT " by a NUL byte. This causes the UDP checksum to become
    corrupt and strips off the OPTIONS argument from the received packet,
    breaking amanda's sendbackup component altogether.  Replace the LF
    character before releasing the buffer.
  
    Signed-off-by: Matthias Andree <matthias.andree@gmx.de>

Matthias Andree

------------------------------------------------------------------------

##### DIFFSTAT #####
 ip_conntrack_amanda.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

##### GNUPATCH #####
--- 1.10/net/ipv4/netfilter/ip_conntrack_amanda.c	2004-08-19 02:14:53 +02:00
+++ 1.11/net/ipv4/netfilter/ip_conntrack_amanda.c	2004-11-04 12:59:26 +01:00
@@ -49,7 +49,7 @@
 {
 	struct ip_conntrack_expect *exp;
 	struct ip_ct_amanda_expect *exp_amanda_info;
-	char *amp, *data, *data_limit, *tmp;
+	char *amp, *data, *data_limit, *tmp, *le = 0;
 	unsigned int dataoff, i;
 	u_int16_t port, len;
 
@@ -83,9 +83,10 @@
 		goto out;
 	data += strlen("CONNECT ");
 
-	/* Only search first line. */	
-	if ((tmp = strchr(data, '\n')))
-		*tmp = '\0';
+	/* Only search first line.
+	 * NB: The change to the data must be reverted later! */
+	if ((le = strchr(data, '\n')))
+		*le = '\0';
 
 	for (i = 0; i < ARRAY_SIZE(conns); i++) {
 		char *match = strstr(data, conns[i]);
@@ -120,6 +121,9 @@
 	}
 
 out:
+	/* replace LF character to repair the packet */
+	if (le)
+	    *le = '\n';
 	UNLOCK_BH(&amanda_buffer_lock);
 	return NF_ACCEPT;
 }



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIADodikECA+1WWW/bRhB+5v6KafIgW4nIXV6SmSpQbCWtEFcyfDw1hbFcLiXWvLC7VCxA
P75D6mhauGhcBH2KJFJ7zH5zfTPYlzCbRpap1JrniZ5ws8qr0jaKl7qQhtuiKrYXK14u5Y00
W5dSF78BG3o0CLcspP5wK1jCGPeZTKjrj0KfvIQ7LVVkFdyYVca1zctESYnrP1faRNayeLST
dnpdVTh1Gq0crYSTZ2XzOHDtcHD+keD2FTdiBWupdGQx2zuumE0tI+v6/U93l++uCRmP4Wgh
jMfk2zpjJC9VVVcTIezfN42dZr8eFPz2VzCfMcpY4DN3uA1Y6IZkCsx2fXcI1HcYc6gPzIso
jQL/FWU4gL9FaLKLDLxiMKDkHL6tJxdEAMCH7BGy+l5UZYlw4uGeF6icQ8INB1Ep1dQmq0qI
myWYFTcQK8kfNBzEmqLWNiIdwXgn+nkllcQD8knwokqaXIKSdc6F1J1cmilt4PJDB8RTIxW8
uFjM5+8vbuEFxBsEnt9d4sBIG25XmQbBG70/fDe9ArGS4kE3BYYJYokRkR3U3gdAxaCNymoN
VZp2pxZXt7PF/Aa4WjaFLA2kqiq6HSWFzNYygRqtluZ1h9R5npXLve89DVqWSYwSTY1qiroq
WxCem2opEUXZANc7FzvQvW9ixTEWrX+xTCvVKssl1y1wKxU3aYpHDyG9yZalTAZo8iDeRPDL
niHwrmMI/Pg0Zd6SjxAwL6Tk6s9iIINnfgihnJK3UEqTZjlaPMlKfGNdPtqxsAXf4o6T1Wvf
OYo4T+TbFi0lPep5zPW8M6wHb0jpcMvdNKVuSgM6FCPXH/4D/5+lpa06fIIzN9z6qM/tGsLX
IrT94v/yliR8LYtJ2Rhtd8O8So2N0M/zl47YGaXMD7yt547Yrssw9kWPcaPgLHLDf+kxIxj4
33vM9x7zrB6zq7AFDNTn/Q8bztfS9z/0o2ngAiOz7m21TkKfF/Vr6LdU2v/d51mRGZyYbgc5
MAb6hkxHIXhkNhqBTyynD4sy32BwucIbxI4XWOnSJhb0YX4eYfplG0ake5vsNmodXYsGJeM2
oHgRMZi9nKODP0DfIVaWwslJpw9JIFbqZGdV71PZOz09JZa1M6b3ifbekBlGDg1qTdlzFJP3
ReJQKa7zTHW6dxw5asklwmHm4IBYIuLxQnRg6Zhzj8mQJuQPFIcUW9cJAAA=
