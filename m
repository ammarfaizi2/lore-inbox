Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbULUQC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbULUQC4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 11:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbULUQC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 11:02:56 -0500
Received: from mproxy.gmail.com ([216.239.56.249]:3785 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261777AbULUQC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 11:02:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=gEqfZE8HjM2iFZfOi+UJzeFV20ZrlcKYPNTl40jU+nvSLfwOQkDEFEvd9DCfh+ye5tELTX5NqcH75HosIOH8XAG89/Y6b0jxjtRVCJb/8Xay3Ddi+bALTz02zyOu/d2vPpu8VugdA3reA2aFdOAENdMNDOfRBqSs7mOPBr8SBLc=
Message-ID: <89245775041221080238187402@mail.gmail.com>
Date: Tue, 21 Dec 2004 10:02:28 -0600
From: Jon Mason <jdmason@gmail.com>
Reply-To: Jon Mason <jdmason@gmail.com>
To: Richard Ems <richard.ems@mtg-marinetechnik.de>
Subject: Re: PROBLEM: Network hang: "eth0: Tx timed out (f0080), is buffer full?"
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <41C7F204.3030503@mtg-marinetechnik.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_40_2701369.1103644948049"
References: <200412171100.16601.richard.ems@mtg-marinetechnik.de>
	 <89245775041217090726eb2751@mail.gmail.com>
	 <41C31421.7090102@mtg-marinetechnik.de>
	 <8924577504121710054331bb54@mail.gmail.com>
	 <8924577504121712527144a5cf@mail.gmail.com>
	 <41C6E2E1.8030801@mtg-marinetechnik.de>
	 <8924577504122009126c40c1fe@mail.gmail.com>
	 <41C713EF.8050003@mtg-marinetechnik.de>
	 <892457750412201231461415a1@mail.gmail.com>
	 <41C7F204.3030503@mtg-marinetechnik.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_40_2701369.1103644948049
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Sorry, I was working off of the mm driver.  I have verified that the
patch below will apply cleanly with the driver you provided (and the
previous patch applies cleanly to the 2.6.10-rc2-mm4 driver).

 =20
--- /root/dl2k.c,orig-save-2004.12.20   2004-12-21 09:46:56.877062552 -0600
+++ dl2k.c      2004-12-20 14:22:31.000000000 -0600
@@ -429,23 +431,14 @@ parse_eeprom (struct net_device *dev)
        return 0;
 }

-static int
-rio_open (struct net_device *dev)
+static void
+rio_up (struct net_device *dev)
 {
-       struct netdev_private *np =3D dev->priv;
+       struct netdev_private *np =3D netdev_priv(dev);
        long ioaddr =3D dev->base_addr;
        int i;
        u16 macctrl;

-       i =3D request_irq (dev->irq, &rio_interrupt, SA_SHIRQ, dev->name, d=
ev);
-       if (i)
-               return i;
-
-       /* Reset all logic functions */
-       writew (GlobalReset | DMAReset | FIFOReset | NetworkReset | HostRes=
et,
-               ioaddr + ASICCtrl + 2);
-       mdelay(10);
-
        /* DebugCtrl bit 4, 5, 9 must set */
        writel (readl (ioaddr + DebugCtrl) | 0x0230, ioaddr + DebugCtrl);

@@ -453,8 +446,6 @@ rio_open (struct net_device *dev)
        if (np->jumbo !=3D 0)
                writew (MAX_JUMBO+14, ioaddr + MaxFrameSize);

-       alloc_list (dev);
-
        /* Get station address */
        for (i =3D 0; i < 6; i++)
                writeb (dev->dev_addr[i], ioaddr + StationAddr0 + i);
@@ -488,12 +479,6 @@ rio_open (struct net_device *dev)
                        ioaddr + MACCtrl);
        }

-       init_timer (&np->timer);
-       np->timer.expires =3D jiffies + 1*HZ;
-       np->timer.data =3D (unsigned long) dev;
-       np->timer.function =3D &rio_timer;
-       add_timer (&np->timer);
-
        /* Start Tx/Rx */
        writel (readl (ioaddr + MACCtrl) | StatsEnable | RxEnable | TxEnabl=
e,
                        ioaddr + MACCtrl);
@@ -505,10 +490,38 @@ rio_open (struct net_device *dev)
        macctrl |=3D (np->rx_flow) ? RxFlowControlEnable : 0;
        writew(macctrl, ioaddr + MACCtrl);

-       netif_start_queue (dev);
-
        /* Enable default interrupts */
        EnableInt ();
+}
+
+static int
+rio_open (struct net_device *dev)
+{
+       struct netdev_private *np =3D netdev_priv(dev);
+       long ioaddr =3D dev->base_addr;
+       int i;
+
+       i =3D request_irq (dev->irq, &rio_interrupt, SA_SHIRQ, dev->name, d=
ev);
+       if (i)
+               return i;
+
+       /* Reset all logic functions */
+       writew (GlobalReset | DMAReset | FIFOReset | NetworkReset | HostRes=
et,
+               ioaddr + ASICCtrl + 2);
+       mdelay(10);
+
+       alloc_list (dev);
+
+       rio_up (dev);
+
+       init_timer (&np->timer);
+       np->timer.expires =3D jiffies + 1*HZ;
+       np->timer.data =3D (unsigned long) dev;
+       np->timer.function =3D &rio_timer;
+       add_timer (&np->timer);
+
+       netif_start_queue (dev);
+
        return 0;
 }

@@ -562,9 +575,11 @@ static void
 rio_tx_timeout (struct net_device *dev)
 {
        long ioaddr =3D dev->base_addr;
+       struct netdev_private *np =3D dev->priv;

-       printk (KERN_INFO "%s: Tx timed out (%4.4x), is buffer full?\n",
-               dev->name, readl (ioaddr + TxStatus));
+       printk (KERN_INFO "%s: Tx timed out (%4.4x) %d %d %x %x\n",
+               dev->name, readl (ioaddr + TxStatus), np->cur_tx, np->cur_r=
x,
+               readl (ioaddr + MACCtrl), readw(ioaddr + IntEnable));
        rio_free_tx(dev, 0);
        dev->if_port =3D 0;
        dev->trans_start =3D jiffies;
@@ -1005,10 +1020,13 @@ rio_error (struct net_device *dev, int i
        /* PCI Error, a catastronphic error related to the bus interface
           occurs, set GlobalReset and HostReset to reset. */
        if (int_status & HostError) {
-               printk (KERN_ERR "%s: HostError! IntStatus %4.4x.\n",
-                       dev->name, int_status);
+               printk (KERN_ERR "%s: HostError! IntStatus %4.4x. %d
%d %x %x\n",
+                       dev->name, int_status, np->cur_tx, np->cur_rx,
+                       readl (ioaddr + MACCtrl), readw(ioaddr + IntEnable)=
);
                writew (GlobalReset | HostReset, ioaddr + ASICCtrl + 2);
                mdelay (500);
+
+               rio_up(dev);
        }
 }

On Tue, 21 Dec 2004 10:51:00 +0100, Richard Ems
<richard.ems@mtg-marinetechnik.de> wrote:
> The patch fails:
>=20
> # patch -p0 < ~ems/dl2k.patch
> patching file dl2k.c
> Hunk #1 FAILED at 431.
> Hunk #2 succeeded at 444 (offset -2 lines).
> Hunk #3 succeeded at 477 (offset -2 lines).
> Hunk #4 succeeded at 488 (offset -2 lines).
> Hunk #5 succeeded at 573 (offset -2 lines).
> Hunk #6 succeeded at 1018 (offset -2 lines).
> 1 out of 6 hunks FAILED -- saving rejects to file dl2k.c.rej
>=20
> I tried with --fuzz 9 but it didn't help.
>=20
> I attached SuSE's original dl2k.c
>=20
> Thanks, Richard
>=20
> --
> Richard Ems
> Tel: +49 40 65803 312
> Fax: +49 40 65803 392
> Richard.Ems@mtg-marinetechnik.de
>=20
> MTG Marinetechnik GmbH - Wandsbeker K=F6nigstr. 62 - D 22041 Hamburg
>=20
> GF Dipl.-Ing. Ullrich Keil
> Handelsregister: Abt. B Nr. 11 500 - Amtsgericht Hamburg Abt. 66
> USt.-IdNr.: DE 1186 70571

------=_Part_40_2701369.1103644948049
Content-Type: application/octet-stream; name="dl2k.patch2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dl2k.patch2"

LS0tIC9yb290L2RsMmsuYyxvcmlnLXNhdmUtMjAwNC4xMi4yMAkyMDA0LTEyLTIxIDA5OjQ2OjU2
Ljg3NzA2MjU1MiAtMDYwMAorKysgZGwyay5jCTIwMDQtMTItMjAgMTQ6MjI6MzEuMDAwMDAwMDAw
IC0wNjAwCkBAIC00MjksMjMgKzQzMSwxNCBAQCBwYXJzZV9lZXByb20gKHN0cnVjdCBuZXRfZGV2
aWNlICpkZXYpCiAJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyBpbnQKLXJpb19vcGVuIChzdHJ1Y3Qg
bmV0X2RldmljZSAqZGV2KQorc3RhdGljIHZvaWQKK3Jpb191cCAoc3RydWN0IG5ldF9kZXZpY2Ug
KmRldikKIHsKLQlzdHJ1Y3QgbmV0ZGV2X3ByaXZhdGUgKm5wID0gZGV2LT5wcml2OworCXN0cnVj
dCBuZXRkZXZfcHJpdmF0ZSAqbnAgPSBuZXRkZXZfcHJpdihkZXYpOwogCWxvbmcgaW9hZGRyID0g
ZGV2LT5iYXNlX2FkZHI7CiAJaW50IGk7CiAJdTE2IG1hY2N0cmw7CiAJCi0JaSA9IHJlcXVlc3Rf
aXJxIChkZXYtPmlycSwgJnJpb19pbnRlcnJ1cHQsIFNBX1NISVJRLCBkZXYtPm5hbWUsIGRldik7
Ci0JaWYgKGkpCi0JCXJldHVybiBpOwotCQotCS8qIFJlc2V0IGFsbCBsb2dpYyBmdW5jdGlvbnMg
Ki8KLQl3cml0ZXcgKEdsb2JhbFJlc2V0IHwgRE1BUmVzZXQgfCBGSUZPUmVzZXQgfCBOZXR3b3Jr
UmVzZXQgfCBIb3N0UmVzZXQsCi0JCWlvYWRkciArIEFTSUNDdHJsICsgMik7Ci0JbWRlbGF5KDEw
KTsKLQkKIAkvKiBEZWJ1Z0N0cmwgYml0IDQsIDUsIDkgbXVzdCBzZXQgKi8KIAl3cml0ZWwgKHJl
YWRsIChpb2FkZHIgKyBEZWJ1Z0N0cmwpIHwgMHgwMjMwLCBpb2FkZHIgKyBEZWJ1Z0N0cmwpOwog
CkBAIC00NTMsOCArNDQ2LDYgQEAgcmlvX29wZW4gKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCiAJ
aWYgKG5wLT5qdW1ibyAhPSAwKQogCQl3cml0ZXcgKE1BWF9KVU1CTysxNCwgaW9hZGRyICsgTWF4
RnJhbWVTaXplKTsKIAotCWFsbG9jX2xpc3QgKGRldik7Ci0KIAkvKiBHZXQgc3RhdGlvbiBhZGRy
ZXNzICovCiAJZm9yIChpID0gMDsgaSA8IDY7IGkrKykKIAkJd3JpdGViIChkZXYtPmRldl9hZGRy
W2ldLCBpb2FkZHIgKyBTdGF0aW9uQWRkcjAgKyBpKTsKQEAgLTQ4OCwxMiArNDc5LDYgQEAgcmlv
X29wZW4gKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCiAJCQlpb2FkZHIgKyBNQUNDdHJsKTsKIAl9
CiAKLQlpbml0X3RpbWVyICgmbnAtPnRpbWVyKTsKLQlucC0+dGltZXIuZXhwaXJlcyA9IGppZmZp
ZXMgKyAxKkhaOwotCW5wLT50aW1lci5kYXRhID0gKHVuc2lnbmVkIGxvbmcpIGRldjsKLQlucC0+
dGltZXIuZnVuY3Rpb24gPSAmcmlvX3RpbWVyOwotCWFkZF90aW1lciAoJm5wLT50aW1lcik7Ci0K
IAkvKiBTdGFydCBUeC9SeCAqLwogCXdyaXRlbCAocmVhZGwgKGlvYWRkciArIE1BQ0N0cmwpIHwg
U3RhdHNFbmFibGUgfCBSeEVuYWJsZSB8IFR4RW5hYmxlLCAKIAkJCWlvYWRkciArIE1BQ0N0cmwp
OwpAQCAtNTA1LDEwICs0OTAsMzggQEAgcmlvX29wZW4gKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYp
CiAJbWFjY3RybCB8PSAobnAtPnJ4X2Zsb3cpID8gUnhGbG93Q29udHJvbEVuYWJsZSA6IDA7CiAJ
d3JpdGV3KG1hY2N0cmwsCWlvYWRkciArIE1BQ0N0cmwpOwogCi0JbmV0aWZfc3RhcnRfcXVldWUg
KGRldik7Ci0JCiAJLyogRW5hYmxlIGRlZmF1bHQgaW50ZXJydXB0cyAqLwogCUVuYWJsZUludCAo
KTsKK30KKworc3RhdGljIGludAorcmlvX29wZW4gKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCit7
CisJc3RydWN0IG5ldGRldl9wcml2YXRlICpucCA9IG5ldGRldl9wcml2KGRldik7CisJbG9uZyBp
b2FkZHIgPSBkZXYtPmJhc2VfYWRkcjsKKwlpbnQgaTsKKwkKKwlpID0gcmVxdWVzdF9pcnEgKGRl
di0+aXJxLCAmcmlvX2ludGVycnVwdCwgU0FfU0hJUlEsIGRldi0+bmFtZSwgZGV2KTsKKwlpZiAo
aSkKKwkJcmV0dXJuIGk7CisJCisJLyogUmVzZXQgYWxsIGxvZ2ljIGZ1bmN0aW9ucyAqLworCXdy
aXRldyAoR2xvYmFsUmVzZXQgfCBETUFSZXNldCB8IEZJRk9SZXNldCB8IE5ldHdvcmtSZXNldCB8
IEhvc3RSZXNldCwKKwkJaW9hZGRyICsgQVNJQ0N0cmwgKyAyKTsKKwltZGVsYXkoMTApOworCQor
CWFsbG9jX2xpc3QgKGRldik7CisKKwlyaW9fdXAgKGRldik7CisJCisJaW5pdF90aW1lciAoJm5w
LT50aW1lcik7CisJbnAtPnRpbWVyLmV4cGlyZXMgPSBqaWZmaWVzICsgMSpIWjsKKwlucC0+dGlt
ZXIuZGF0YSA9ICh1bnNpZ25lZCBsb25nKSBkZXY7CisJbnAtPnRpbWVyLmZ1bmN0aW9uID0gJnJp
b190aW1lcjsKKwlhZGRfdGltZXIgKCZucC0+dGltZXIpOworCisJbmV0aWZfc3RhcnRfcXVldWUg
KGRldik7CisJCiAJcmV0dXJuIDA7CiB9CiAKQEAgLTU2Miw5ICs1NzUsMTEgQEAgc3RhdGljIHZv
aWQKIHJpb190eF90aW1lb3V0IChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQogewogCWxvbmcgaW9h
ZGRyID0gZGV2LT5iYXNlX2FkZHI7CisJc3RydWN0IG5ldGRldl9wcml2YXRlICpucCA9IGRldi0+
cHJpdjsKIAotCXByaW50ayAoS0VSTl9JTkZPICIlczogVHggdGltZWQgb3V0ICglNC40eCksIGlz
IGJ1ZmZlciBmdWxsP1xuIiwKLQkJZGV2LT5uYW1lLCByZWFkbCAoaW9hZGRyICsgVHhTdGF0dXMp
KTsKKwlwcmludGsgKEtFUk5fSU5GTyAiJXM6IFR4IHRpbWVkIG91dCAoJTQuNHgpICVkICVkICV4
ICV4XG4iLAorCQlkZXYtPm5hbWUsIHJlYWRsIChpb2FkZHIgKyBUeFN0YXR1cyksIG5wLT5jdXJf
dHgsIG5wLT5jdXJfcngsCisJCXJlYWRsIChpb2FkZHIgKyBNQUNDdHJsKSwgcmVhZHcoaW9hZGRy
ICsgSW50RW5hYmxlKSk7CiAJcmlvX2ZyZWVfdHgoZGV2LCAwKTsKIAlkZXYtPmlmX3BvcnQgPSAw
OwogCWRldi0+dHJhbnNfc3RhcnQgPSBqaWZmaWVzOwpAQCAtMTAwNSwxMCArMTAyMCwxMyBAQCBy
aW9fZXJyb3IgKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIGludCBpCiAJLyogUENJIEVycm9yLCBh
IGNhdGFzdHJvbnBoaWMgZXJyb3IgcmVsYXRlZCB0byB0aGUgYnVzIGludGVyZmFjZSAKIAkgICBv
Y2N1cnMsIHNldCBHbG9iYWxSZXNldCBhbmQgSG9zdFJlc2V0IHRvIHJlc2V0LiAqLwogCWlmIChp
bnRfc3RhdHVzICYgSG9zdEVycm9yKSB7Ci0JCXByaW50ayAoS0VSTl9FUlIgIiVzOiBIb3N0RXJy
b3IhIEludFN0YXR1cyAlNC40eC5cbiIsCi0JCQlkZXYtPm5hbWUsIGludF9zdGF0dXMpOworCQlw
cmludGsgKEtFUk5fRVJSICIlczogSG9zdEVycm9yISBJbnRTdGF0dXMgJTQuNHguICVkICVkICV4
ICV4XG4iLAorCQkJZGV2LT5uYW1lLCBpbnRfc3RhdHVzLCBucC0+Y3VyX3R4LCBucC0+Y3VyX3J4
LAorCQkJcmVhZGwgKGlvYWRkciArIE1BQ0N0cmwpLCByZWFkdyhpb2FkZHIgKyBJbnRFbmFibGUp
KTsKIAkJd3JpdGV3IChHbG9iYWxSZXNldCB8IEhvc3RSZXNldCwgaW9hZGRyICsgQVNJQ0N0cmwg
KyAyKTsKIAkJbWRlbGF5ICg1MDApOworCisJCXJpb191cChkZXYpOwogCX0KIH0K
------=_Part_40_2701369.1103644948049--
