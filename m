Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318016AbSIMDZa>; Thu, 12 Sep 2002 23:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318227AbSIMDZa>; Thu, 12 Sep 2002 23:25:30 -0400
Received: from kraid.nerim.net ([62.4.16.95]:8207 "HELO kraid.nerim.net")
	by vger.kernel.org with SMTP id <S318016AbSIMDZ3>;
	Thu, 12 Sep 2002 23:25:29 -0400
From: "Yann E. MORIN" <yann.morin.1998@anciens.enib.fr>
Organization: ENIB - Anciens
To: linux-kernel@vger.kernel.org
Subject: [2.4.19] [2.4.20-pre6] loop.c memory allocation & freeing problem
Date: Thu, 12 Sep 2002 22:28:29 +0200
X-Mailer: KMail [version 1.3.2]
X-Eric-Conspiracy: There is no conspiracy
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_H7EC9IB1C70VXNCU5GUZ"
Message-Id: <20020912201951.1CAA7446BA@kraid.nerim.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_H7EC9IB1C70VXNCU5GUZ
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit

Hi All!

I think I've spotted a bug in the initialisation procedure in the loop driver,
@line 1027-1060, when there is allocation failure:

----BEGIN CODE----
        loop_dev = kmalloc(max_loop * sizeof(struct loop_device), GFP_KERNEL);
        if (!loop_dev)
                return -ENOMEM;

        loop_sizes = kmalloc(max_loop * sizeof(int), GFP_KERNEL);
        if (!loop_sizes)
                goto out_sizes;

        loop_blksizes = kmalloc(max_loop * sizeof(int), GFP_KERNEL);
        if (!loop_blksizes)
                goto out_blksizes;

[...SNIP...]

out_sizes:
        kfree(loop_dev);
out_blksizes:
        kfree(loop_sizes);
----END CODE----

Two problems arise there:
1) Should allocation of loop_sizes fail, we'll try to free loop_sizes that
   was NOT allocated (no problem because kfree does not free a NULL pointer).
   But not very clean...

2) Should allocation of loop_blksizes fail, loop_dev will NOT be freed.
   That one looks more problematic.

Am I wrong? Have I missed something? Anyway it's been there for ages, I
suppose.

Patch is very straigthforward, and is attached : swap the last 2 pairs of
lines, so that out_blksizes is before out_sizes, and kfree(loop_sizes is
before kfree(loop_dev).

Please CC: answers and comments as I'm no longer subscribed.

Cheers,
Yann.

-- 
.-----------------.--------------------.------------------.--------------------.
|  Yann E. MORIN  | Real-Time Embedded | /"\ ASCII RIBBON | Erics' conspiracy: |
|  0 662 376 056  | Software  Designer | \ / CAMPAIGN     |  ___               |
| --==< °_° >==-- °---.----------------:  X  AGAINST      |  \e/  There is no  |
| web: ymorin.free.fr | SETI@home  433 | / \ HTML MAIL    |   v   conspiracy.  |
°---------------------°----------------°------------------°--------------------°

--------------Boundary-00=_H7EC9IB1C70VXNCU5GUZ
Content-Type: text/plain;
  charset="iso-8859-15";
  name="loop.c.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="loop.c.diff"

LS0tIGxvb3AuYy5vbGQJVGh1IFNlcCAxMiAyMToxOTo0MCAyMDAyCisrKyBsb29wLmMJVGh1IFNl
cCAxMiAyMToxOTo1NiAyMDAyCkBAIC0xMDU0LDEwICsxMDU0LDEwIEBACiAJcHJpbnRrKEtFUk5f
SU5GTyAibG9vcDogbG9hZGVkIChtYXggJWQgZGV2aWNlcylcbiIsIG1heF9sb29wKTsKIAlyZXR1
cm4gMDsKIAotb3V0X3NpemVzOgotCWtmcmVlKGxvb3BfZGV2KTsKIG91dF9ibGtzaXplczoKIAlr
ZnJlZShsb29wX3NpemVzKTsKK291dF9zaXplczoKKwlrZnJlZShsb29wX2Rldik7CiAJcHJpbnRr
KEtFUk5fRVJSICJsb29wOiByYW4gb3V0IG9mIG1lbW9yeVxuIik7CiAJcmV0dXJuIC1FTk9NRU07
CiB9Cg==

--------------Boundary-00=_H7EC9IB1C70VXNCU5GUZ--
