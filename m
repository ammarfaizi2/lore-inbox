Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267635AbUHSACK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267635AbUHSACK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 20:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267670AbUHSACJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 20:02:09 -0400
Received: from hell.org.pl ([212.244.218.42]:45068 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S267660AbUHSAAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 20:00:38 -0400
Date: Thu, 19 Aug 2004 02:00:45 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Eric Valette <eric.valette@free.fr>
Cc: len.brown@intel.com, zhenyu.z.wang@intel.com,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, linux@brodo.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm1 and Asus L3C : problematic change found, can be reverted. Real fix still missing
Message-ID: <20040819000045.GA9079@hell.org.pl>
References: <41189098.4000400@free.fr> <4118A500.1080306@free.fr> <20040810090743.3fa75a74.akpm@osdl.org> <4123AC79.5000709@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <4123AC79.5000709@free.fr>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, so I think I've finally got what's happening here.
Enabling the SMBus device (00:1f.3) seems to mess up the resource
reservation code, specifically the 0xe800 port region. Here's the diff
between 2.6.8.1-mm1 acpi=off and the same kernel with no arguments:

#v+
 0cf8-0cff : PCI conf1
+1000-101f : 0000:00:1f.3
 4000-40ff : PCI CardBus #03
[...]
 e300-e37f : 0000:00:1f.6
-e400-e47f : pnp 00:11
-  e400-e47f : 0000:00:1f.0
-e800-e81f : 0000:00:1f.3
-ec00-ec3f : pnp 00:11
-  ec00-ec3f : 0000:00:1f.0
+e400-e47f : 0000:00:1f.0
+  e400-e47f : motherboard
+    e400-e403 : PM1a_EVT_BLK
+    e404-e405 : PM1a_CNT_BLK
+    e408-e40b : PM_TMR
+    e410-e415 : ACPI CPU throttle
+    e428-e42b : GPE0_BLK
+    e42c-e42f : GPE1_BLK
+e800-e81f : motherboard
+ec00-ec3f : 0000:00:1f.0
+  ec00-ec3f : motherboard
+    ec00-ec3f : pnp 00:11
 00000000-0009fbff : System RAM
#v-

Note that since ACPI reserves the 0xe800-0xe81f region, the SMBus gets
assigned a bogus port range. The next relevant piece of code is from the
DSDT:

#v+
Device (SBIO)
{
    Name (_HID, EisaId ("PNP0C02"))
    Name (_UID, 0x04)
    Method (_CRS, 0, NotSerialized)
    {
        Name (BUF1, ResourceTemplate ()
        {
            IO (Decode16, 0xE400, 0xE400, 0x01, 0x80)
=>          IO (Decode16, 0xE800, 0xE800, 0x01, 0x20)  <=
            IO (Decode16, 0xEC00, 0xEC00, 0x01, 0x40)
            IO (Decode16, 0x040B, 0x040B, 0x01, 0x01)
            IO (Decode16, 0x0480, 0x0480, 0x01, 0x10)
            IO (Decode16, 0x04D6, 0x04D6, 0x01, 0x01)
        })
        Return (BUF1)
    }
}
[...]
OperationRegion (SMB0, SystemIO, 0xE800, 0x10)
Field (SMB0, ByteAcc, NoLock, Preserve)
{
=>  HSTS,   8,  <=
    SSTS,   8,
    HSTC,   8,
    HCMD,   8,
[...]
}
#v-

And that leads us to the root of the problem: _TMP calls RTMP, which calls
RBYT and finally HBSY. The latter attempts to access HSTS and subsequently
fails (hence _TMP returns 0x7f and kacpid loops).

Now, I see two possibilities: either the resource allocation code is buggy
and should be fixed (hopefully by someone with better understanding than
me) or the code relies on the necessary information that is not exported by
the BIOS / DSDT (which wouldn't be strange assuming the system is supposed
to run with SMBus disabled), and in that case the SMBus fixup should be
reverted. 

A similar patch went in for ASUS M2400N, so I guess those systems could
also be affected.

Dmesg, ioports and iomem of plain 2.6.8.1-mm1 with and without acpi-off as
well as dmesg found at http://hell.org.pl/~sziwan/asus/l3c/ (note the extra
IRQ 0 and 0xe400 problem when ACPI is on).

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
