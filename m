Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274001AbRJDOG4>; Thu, 4 Oct 2001 10:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273702AbRJDOGr>; Thu, 4 Oct 2001 10:06:47 -0400
Received: from mail.case.pt ([194.65.97.60]:58382 "EHLO case_primary.case.pt")
	by vger.kernel.org with ESMTP id <S274001AbRJDOGh>;
	Thu, 4 Oct 2001 10:06:37 -0400
Message-ID: <01C14CE5.1AB536F0.rui.ribeiro@case.pt>
From: Rui Ribeiro <rui.ribeiro@case.pt>
Reply-To: "rui.ribeiro@case.pt" <rui.ribeiro@case.pt>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Reproducible oops in 2.4.10, khttpd crashing when apache is not running ; corresponding HTTP error message
Date: Thu, 4 Oct 2001 14:59:01 +0100
Organization: Case, S.A.
X-Mailer: Microsoft Internet E-mail/MAPI - 8.0.0.4211
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="---- =_NextPart_000_01C14CE5.1AB536F0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


------ =_NextPart_000_01C14CE5.1AB536F0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

 

Howdy,

First I would like to say hello to everyone in this list.

I'm running kernel 2.4.10 (Intel), and performing experiments with the 
khttpd server compiled as a module. I am writing to this list concerning a 
couple of things I noticed in khttpd, and offering a fix. I already sent this e-mail 
to the list, but not with a standard subject.
 
Problem description:
-----------------------------

I began noticing that it crashed with a  oops  or hanging the 
machine when apache was not running. When the machine survived, it also 
returned a 403 error,  with a "Permission denied" message.


The hack:
------------------

Upon source investigation, I noticed that at 
/usr/src/linux/net/khttpd/userspace.c, at the function Userspace, in the 
place where's the user-daemon no present case is coded, a structure element 
is not released.

After correction, I have also changed the 403 error (permission denied), to 
a 503 Service Unavailable, as I believe it's more correct. If the khttpd 
daemon can't call Apache (or other userspace daemon) when it's not capable 
of processing the request, it's better to give a 503 message than a 403, 
for  my and the users'  sanity sake.

So, in the  2.4.10 kernel source tree, in the already mentioned 
/usr/src/linux/net/khttpd/userspace.c, at line 114, you can make the 
following changes:

Send403(CurrentRequest->sock); to Send50x(CurrentRequest-sock);

Append the following lines after the Send50x:
sock_release(CurrentRequest->sock);
CurrentRequest->sock=NULL;


This patch has already been tested by another two persorns.

A diff file is included as an attachment.


Regards,
--
Rui Ribeiro
Network and Security consultant
http://www.case.pt


P.S. A copy of this message has already been sent to khttpd users list.

 

------ =_NextPart_000_01C14CE5.1AB536F0
Content-Type: application/octet-stream; name="userspace.diff"
Content-Transfer-Encoding: base64

MTAxZDEwMA0KPCANCjEwMmExMDINCj4gCQkJDQoxMTMsMTE5YzExMywxMTUNCjwgCQ0KPCAvKiBS
dWkgKi8NCjwgCQkJU2VuZDUweChDdXJyZW50UmVxdWVzdC0+c29jayk7IC8qIFNvcnJ5LCBubyBn
by4uLiAqLw0KPCAJCQlzb2NrX3JlbGVhc2UoQ3VycmVudFJlcXVlc3QtPnNvY2spOw0KPCAJCQlD
dXJyZW50UmVxdWVzdC0+c29jayA9IE5VTEw7CSAvKiBXZSBubyBsb25nZXIgb3duIGl0ICovDQo8
IC8qIEVuZCBSdWkgKi8NCjwgDQotLS0NCj4gCQkJDQo+IAkJCVNlbmQ0MDMoQ3VycmVudFJlcXVl
c3QtPnNvY2spOyAvKiBTb3JyeSwgbm8gZ28uLi4gKi8NCj4gCQkJDQo=

------ =_NextPart_000_01C14CE5.1AB536F0--

