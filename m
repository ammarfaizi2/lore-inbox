Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTHUHtZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 03:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbTHUHtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 03:49:24 -0400
Received: from pop.gmx.net ([213.165.64.20]:8407 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262497AbTHUHtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 03:49:19 -0400
Message-Id: <5.2.1.1.2.20030821090657.00b45af8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Thu, 21 Aug 2003 09:53:15 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O17int
Cc: Voluspa <lista1@comhem.se>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200308211526.01796.kernel@kolivas.org>
References: <200308210723.42789.kernel@kolivas.org>
 <200308200102.04155.kernel@kolivas.org>
 <20030820162736.GA711@gmx.de>
 <200308210723.42789.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_12798906==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_12798906==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 03:26 PM 8/21/2003 +1000, Con Kolivas wrote:
>Unhappy with this latest O16.3-O17int patch I'm withdrawing it, and
>recommending nothing on top of O16.3 yet.
>
>More and more it just seems to be a bandaid to the priority inverting spin on
>waiters, and it does seem to be of detriment to general interacivity. I can
>now reproduce some loss of interactive feel with O17.
>
>Something specific for the spin on waiters is required that doesn't affect
>general performance. The fact that I can reproduce the same starvation in
>vanilla 2.6.0-test3 but to a lesser extent means this is an intrinsic problem
>that needs a specific solution.

I can see only one possible answer to this - never allow a normal task to 
hold the cpu for long stretches (define) while there are other tasks 
runnable.  (see attachment)

I think the _easiest_ fix for this particular starvation (without tossing 
baby out with bath water;) is to try to "down-shift" in schedule() when 
next == prev.  This you can do very cheaply with a find_next_bit().  That 
won't help the case where there are multiple tasks involved, but should fix 
the most common case for dirt cheap.  (another simple alternative is to 
globally "down-shift" periodically)

The most generally effective form of the "down-shift" anti-starvation 
tactic that I've tried, is to periodically check the head of all queues 
below current position (can do very quickly), and actively select the 
oldest task who hasn't run since some defined deadline.  Queues are 
serviced based upon priority most of the time, and based upon age some of 
the time.

Everything I've tried along these lines has a common upside: works, and 
downside: butt ugly :)

         -Mike 
--=====================_12798906==_
Content-Type: application/octet-stream; name="strace-blender"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="strace-blender"

PFNOSVA+CjEwNjE0NDU4MTAuODEyNDU0IHNvY2tldChQRl9VTklYLCBTT0NLX1NUUkVBTSwgMCkg
PSAzIDwwLjAwMDA3Mz4KMTA2MTQ0NTgxMC44MTI3MDQgdW5hbWUoe3N5cz0iTGludXgiLCBub2Rl
PSJtaWtlZyIsIC4uLn0pID0gMCA8MC4wMDAwMjA+CjEwNjE0NDU4MTAuODEzMDE0IHVuYW1lKHtz
eXM9IkxpbnV4Iiwgbm9kZT0ibWlrZWciLCAuLi59KSA9IDAgPDAuMDAwMDE5PgoxMDYxNDQ1ODEw
LjgxMzQwMCBjb25uZWN0KDMsIHtzaW5fZmFtaWx5PUFGX1VOSVgsIHBhdGg9Ii90bXAvLlgxMS11
bml4L1gwIn0sIDE5KSA9IDAgPDAuMDAwMzcyPgoxMDYxNDQ1ODEwLjgxMzk4OCB1bmFtZSh7c3lz
PSJMaW51eCIsIG5vZGU9Im1pa2VnIiwgLi4ufSkgPSAwIDwwLjAwMDAyMT4KMTA2MTQ0NTgxMC44
MTQzNDUgZmNudGw2NCgzLCBGX1NFVEZELCBGRF9DTE9FWEVDKSA9IDAgPDAuMDAwMDIxPgoxMDYx
NDQ1ODEwLjgxNDYwMCBhY2Nlc3MoIi9yb290Ly5YYXV0aG9yaXR5IiwgUl9PSykgPSAwIDwwLjAw
MDAzNj4KMTA2MTQ0NTgxMC44MTQ4MDQgb3BlbigiL3Jvb3QvLlhhdXRob3JpdHkiLCBPX1JET05M
WSkgPSA0IDwwLjAwMDA1Nz4KMTA2MTQ0NTgxMC44MTUwNDAgZnN0YXQ2NCg0LCB7c3RfbW9kZT1T
X0lGUkVHfDA2MDAsIHN0X3NpemU9MTAzLCAuLi59KSA9IDAgPDAuMDAwMDIyPgoxMDYxNDQ1ODEw
LjgxNTIzMyBvbGRfbW1hcChOVUxMLCA0MDk2LCBQUk9UX1JFQUR8UFJPVF9XUklURSwgTUFQX1BS
SVZBVEV8TUFQX0FOT05ZTU9VUywgLTEsIDApID0gMHg0MDRjZDAwMCA8MC4wMDAwMzE+CjEwNjE0
NDU4MTAuODE1NDEzIHJlYWQoNCwgIlwxXDBcMFx0ZWwta2Fib29tXDBcMDAxMFwwXDIyTUlULU1B
R0lDLUNPT0siLi4uLCA0MDk2KSA9IDEwMyA8MC4wMDAwODQ+CjEwNjE0NDU4MTAuODE1NzIzIHJl
YWQoNCwgIiIsIDQwOTYpICAgICA9IDAgPDAuMDAwMDIyPgoxMDYxNDQ1ODEwLjgxNTkwOSBjbG9z
ZSg0KSAgICAgICAgICAgICAgPSAwIDwwLjAwMDAyNj4KPFNOSVA+CjEwNjE0NDU4MTAuODI0NjI2
IHNvY2tldChQRl9VTklYLCBTT0NLX1NUUkVBTSwgMCkgPSA0IDwwLjAwMDA0Nz4KMTA2MTQ0NTgx
MC44MjQ3ODkgdW5hbWUoe3N5cz0iTGludXgiLCBub2RlPSJtaWtlZyIsIC4uLn0pID0gMCA8MC4w
MDAwMjA+CjEwNjE0NDU4MTAuODI1MDk1IHVuYW1lKHtzeXM9IkxpbnV4Iiwgbm9kZT0ibWlrZWci
LCAuLi59KSA9IDAgPDAuMDAwMDE5PgoxMDYxNDQ1ODEwLjgyNTM5MiBjb25uZWN0KDQsIHtzaW5f
ZmFtaWx5PUFGX1VOSVgsIHBhdGg9Ii90bXAvLlgxMS11bml4L1gwIn0sIDE5KSA9IDAgPDAuMDAw
MjQyPgo8U05JUCA0MGsgbGluZXM+CjEwNjE0NDU4MzQuMzY4MDY4IHNlbGVjdCg0LCBbM10sIE5V
TEwsIE5VTEwsIE5VTEwpID0gMSAoaW4gWzNdKSA8MC4wMDAxNjM+CjEwNjE0NDU4MzQuMzY4NDY5
IHJlYWQoMywgIlwxXDBcMzU0XCJcMFwwXDBcMFwwXDBcMFwwXDFcMFwwXDBcMFwyN1wwXDBcMFww
XDBcMFwwXDAiLi4uLCAzMikgPSAzMiA8MC4wMDAwMjU+CjEwNjE0NDU4MzQuMzY4Njk4IHdyaXRl
KDMsICJcMjIxXHZcM1wwXDFcMFwwXDBcMlwwXDMwMFwxIiwgMTIpID0gMTIgPDAuMDAwMDI2Pgox
MDYxNDQ1ODM0LjM2ODg3NiB3cml0ZXYoMywgW3siXDIyMVwwMDEyXDBcMVwwXDBcMCIsIDh9LCB7
IlwyNFwwXDI3N1wwXDBcMFwwXDBcMzRcMVwwXDBcMFw1XDBcMFwzMTJcMlwwXDBcMjRcMGdcMCIu
Li4sIDE5Mn1dLCAyKSA9IDIwMCA8MC4wMDAwMjk+CjEwNjE0NDU4MzQuMzY5MTUyIHdyaXRlKDMs
ICJcMjIxbFwyXDBcMVwwXDBcMCIsIDgpID0gOCA8MC4wMDAwMjY+CjEwNjE0NDU4MzQuMzY5MzI4
IHJlYWQoMywgMHhiZmZmZjRjOCwgMzIpID0gLTEgRUFHQUlOIChSZXNvdXJjZSB0ZW1wb3Jhcmls
eSB1bmF2YWlsYWJsZSkgPDAuMDAwMDIyPgoxMDYxNDQ1ODM0LjM2OTQ2MiBzZWxlY3QoNCwgWzNd
LCBOVUxMLCBOVUxMLCBOVUxMKSA9IDEgKGluIFszXSkgPDAuMDMyNzA0PgoxMDYxNDQ1ODM0LjQw
MjU1MyByZWFkKDMsICJcMVwwXDM1N1wiXDBcMFwwXDBcMFwwXDBcMFwxXDBcMFwwXDBcMjdcMFww
XDBcMFwwXDBcMFwwIi4uLiwgMzIpID0gMzIgPDAuMDAwMDMxPgoxMDYxNDQ1ODM0LjQwMjc3MyBn
ZXR0aW1lb2ZkYXkoezEwNjE0NDU4MzQsIDQwMjgxOH0sIE5VTEwpID0gMCA8MC4wMDAwMTg+CjEw
NjE0NDU4MzQuNDAyOTEzIGlvY3RsKDMsIEZJT05SRUFELCBbMF0pID0gMCA8MC4wMDAwMjE+CjEw
NjE0NDU4MzQuNDAzMDU2IGdldHRpbWVvZmRheSh7MTA2MTQ0NTgzNCwgNDAzMDk5fSwgTlVMTCkg
PSAwIDwwLjAwMDAxOD4KMTA2MTQ0NTgzNC40MDMxODQgZ2V0dGltZW9mZGF5KHsxMDYxNDQ1ODM0
LCA0MDMyMjh9LCBOVUxMKSA9IDAgPDAuMDAwMDE4PgoxMDYxNDQ1ODM0LjQwMzM1NSBpb2N0bCgz
LCBGSU9OUkVBRCwgWzBdKSA9IDAgPDAuMDAwMDIwPgoxMDYxNDQ1ODM0LjQwMzQ4OSBnZXR0aW1l
b2ZkYXkoezEwNjE0NDU4MzQsIDQwMzUzMn0sIE5VTEwpID0gMCA8MC4wMDAwMTk+CjEwNjE0NDU4
MzQuNDAzNjE3IGdldHRpbWVvZmRheSh7MTA2MTQ0NTgzNCwgNDAzNjYxfSwgTlVMTCkgPSAwIDww
LjAwMDAxOD4KMTA2MTQ0NTgzNC40MDM3NDUgaW9jdGwoMywgRklPTlJFQUQsIFswXSkgPSAwIDww
LjAwMDAxOT4KMTA2MTQ0NTgzNC40MDM4NzYgZ2V0dGltZW9mZGF5KHsxMDYxNDQ1ODM0LCA0MDM5
MTl9LCBOVUxMKSA9IDAgPDAuMDAwMDE4PgoxMDYxNDQ1ODM0LjQwNDAwMiBnZXR0aW1lb2ZkYXko
ezEwNjE0NDU4MzQsIDQwNDA0NX0sIE5VTEwpID0gMCA8MC4wMDAwMTg+CjEwNjE0NDU4MzQuNDA0
MTc2IGlvY3RsKDMsIEZJT05SRUFELCBbMF0pID0gMCA8MC4wMDAwMjE+Cgo8WlpaWlouLi4gYW5k
IGFmdGVyIH4yIHNlY29uZHMgdW5pbnRlcnJ1cHRlZCB0aHVtYiB0d2lkZGxpbmc+CgoxMDYxNDQ1
ODM2LjMwNjk1OCBpb2N0bCgzLCBGSU9OUkVBRCwgWzMyXSkgPSAwIDwwLjAwMTgyND4KMTA2MTQ0
NTgzNi4zMDg5MzUgcmVhZCgzLCAiXDZcMFwzNTdcIlwyM1wzNlwzMiM/XDBcMFwwXDJcMFwzMDBc
MVwwXDBcMFwwXDBcMHBcMVwwIi4uLiwgMzIpID0gMzIgPDAuMDAwMDI4PgoxMDYxNDQ1ODM2LjMw
OTE5NCBnZXR0aW1lb2ZkYXkoezEwNjE0NDU4MzYsIDMwOTI0MH0sIE5VTEwpID0gMCA8MC4wMDAw
MTk+CjEwNjE0NDU4MzYuMzA5MzMxIGlvY3RsKDMsIEZJT05SRUFELCBbMF0pID0gMCA8MC4wMDAw
MjE+CjEwNjE0NDU4MzYuMzA5NDk2IHdyaXRlKDMsICIobFw0XDA/XDBcMFwwXDJcMFwzMDBcMVww
XDBwXDEiLCAxNikgPSAxNiA8MC4wMDAwMjk+CjEwNjE0NDU4MzYuMzA5NjcyIHJlYWQoMywgMHhi
ZmZmZjJjNCwgMzIpID0gLTEgRUFHQUlOIChSZXNvdXJjZSB0ZW1wb3JhcmlseSB1bmF2YWlsYWJs
ZSkgPDAuMDAwMDIyPgo=
--=====================_12798906==_--

