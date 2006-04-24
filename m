Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWDXP6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWDXP6E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 11:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWDXP6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 11:58:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:47520 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750940AbWDXP6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 11:58:03 -0400
X-IronPort-AV: i="4.04,152,1144047600"; 
   d="scan'208"; a="26989283:sNHT2899375836"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C667B7.DB2CDD9F"
Subject: RE: Problems with EDAC coexisting with BIOS
Date: Mon, 24 Apr 2006 08:57:53 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392DA23445@orsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with EDAC coexisting with BIOS
Thread-Index: AcZnoDmPFuPhj0iORs6Qv7t6o/u7iAAD+tUQ
From: "Gross, Mark" <mark.gross@intel.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <bluesmoke-devel@lists.sourceforge.net>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
X-OriginalArrivalTime: 24 Apr 2006 15:57:58.0652 (UTC) FILETIME=[DB8943C0:01C667B7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C667B7.DB2CDD9F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



>-----Original Message-----
>From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
>Sent: Monday, April 24, 2006 6:19 AM
>To: Gross, Mark
>Cc: bluesmoke-devel@lists.sourceforge.net; LKML; Carbonari, Steven;
Ong,
>Soo Keong; Wang, Zhenyu Z
>Subject: Re: Problems with EDAC coexisting with BIOS
>
>On Gwe, 2006-04-21 at 09:01 -0700, Gross, Mark wrote:
>> 1) The default AMI BIOS behavior on SMI is to check the chipset error
>> registers (Dev0:Fun1) and re-hide them.
>
>The words "bad design" come to mind (followed by a large number of more
>accurate phrases that are inappropriate for a public list)
>

Yes, EDAC should not have existed without first working more closely
with the BIOS folks.  It's too bad we (Intel) didn't catch this.  The
BIOS folks where not in the loop with the driver folks making
contributions to EDAC previously.

>> Basically if device 0 : function 1 is hidden by the platform at boot
>> time un-hiding and using the device and function is a risky thing to
do,
>
>Intel provided patches that do exactly this for some of the chip
>workarounds. Are you saying the Intel chip work around also needs
>fixing ?
>

I think what I'm saying is pretty clear and I don't think it is related
to whatever workarounds where done earlier.

>> The driver should never get loaded by default or automatically.  If
the
>> user knows enough about there BIOS to trust that the SMI behavior
will
>> coexist with the driver then its OK to load otherwise using this
driver
>> is not a safe thing to do.
>
>So Intel and/or the BIOS vendors also forgot to put in any kind of
>indicator ? How do they expect end users to know this, or OS vendors ?
>Is there a technote that covers this mess ?
>

I don't know of any technote.  It took me working with Soo Keong for a
few weeks to chase this issue down to the level I have.  The short
answer is that the BIOS assumes the payload OS would not be fighting it
for hidden device access and the EDAC driver violates this assumption. =20

>> I think the best thing to do is to have the driver error out in its
init
>> or probe code if the dev0:fun1 is hidden at boot time.
>>
>> Comments?
>
>Why did Intel bother implementing this functionality and then screwing
>it up so that OS vendors can't use it ? It seems so bogus.
>

It was just a screw up not to have identified this issue sooner. =20

>At the very least we should print a warning advising the user that the
>BIOS is incompatible and to ask the BIOS vendor for an update so that
>they can enable error detection and management support.

I would place the warning in the probe or init code.

Attached is a test patch I'm testing now.  I don't like it, but it seems
to be working so far.  It basically fails the probe call leaving the
driver loaded.  I'm going to move the test to e752x_int so the driver
fails at init this am at restart my tests.


>
>Is only the AMI BIOS this braindamaged, should we just blacklist AMI
>bioses in EDAC or is this shared Intel supplied code that may be found
>in other vendors systems.
>

Unknown.  Also the BOIS teams for various platforms can modify the base
AMI functionality.  I know that at least one Intel e7520 based system
with AMI based bios seems to not expose this issue.  The point is that
without working out a handshake between the OS and the platform / BIOS
for this type of thing, loading EDAC without a patch like mine is
equivalent to playing Russian roulette.  You can't know which platform /
bios will blow up on you if you load the thing.

--mgross


------_=_NextPart_001_01C667B7.DB2CDD9F
Content-Type: application/octet-stream;
	name="edac_2_6_16.patch"
Content-Transfer-Encoding: base64
Content-Description: edac_2_6_16.patch
Content-Disposition: attachment;
	filename="edac_2_6_16.patch"

PyBzY3JpcHRzL2tjb25maWcvbHhkaWFsb2cvbHhkaWFsb2cNCkluZGV4OiBkcml2ZXJzL2VkYWMv
ZTc1MnhfZWRhYy5jDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL29wdC9DVlMvbGludXgvZHJpdmVy
cy9lZGFjL2U3NTJ4X2VkYWMuYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMS4xLjENCmRpZmYg
LXUgLXIxLjEuMS4xIGU3NTJ4X2VkYWMuYw0KLS0tIGRyaXZlcnMvZWRhYy9lNzUyeF9lZGFjLmMJ
MjEgQXByIDIwMDYgMDI6NTg6MzIgLTAwMDAJMS4xLjEuMQ0KKysrIGRyaXZlcnMvZWRhYy9lNzUy
eF9lZGFjLmMJMjMgQXByIDIwMDYgMjM6NDI6MTkgLTAwMDANCkBAIC03NTUsMTAgKzc1NSwxMyBA
QA0KIAlkZWJ1Z2YwKCJNQzogIiBfX0ZJTEVfXyAiOiAlcygpOiBtY2lcbiIsIF9fZnVuY19fKTsN
CiAJZGVidWdmMCgiU3RhcnRpbmcgUHJvYmUxXG4iKTsNCiANCi0JLyogZW5hYmxlIGRldmljZSAw
IGZ1bmN0aW9uIDEgKi8NCisJLyogY2hlY2sgdG8gc2VlIGlmIGRldmljZSAwIGZ1bmN0aW9uIDEg
aXMgZW5iYWxlZCBpZiBpdCBpc24ndCB3ZSBhc3N1bWUNCisJICogdGhlIEJJT1MgaGFzIHJlc2Vy
dmVkIGl0IGZvciBhIHJlYXNvbiBsaWtlLCBpdCBoYXMgU01JJ3Mgc2V0dXANCisJICogZXhwZWN0
aW5nIGV4Y2x1c2l2ZSBhY2Nlc3MsIGFuZCB3ZSBzb3VsZCB0YWtlIGNhcmUgdG8gbm90IHZpb2xh
dGUNCisJICogdGhhdCBhc3N1bXB0aW9uIGFuZCBmYWlsIHRoZSBwcm9iZS4gKi8NCiAJcGNpX3Jl
YWRfY29uZmlnX2J5dGUocGRldiwgRTc1MlhfREVWUFJFUzEsICZzdGF0OCk7DQotCXN0YXQ4IHw9
ICgxIDw8IDUpOw0KLQlwY2lfd3JpdGVfY29uZmlnX2J5dGUocGRldiwgRTc1MlhfREVWUFJFUzEs
IHN0YXQ4KTsNCisJaWYgKCEoc3RhdDggJiAoMSA8PCA1KSkNCisJCWdvdG8gZmFpbDsNCiANCiAJ
LyogbmVlZCB0byBmaW5kIG91dCB0aGUgbnVtYmVyIG9mIGNoYW5uZWxzICovDQogCXBjaV9yZWFk
X2NvbmZpZ19kd29yZChwZGV2LCBFNzUyWF9EUkMsICZkcmMpOw0K

------_=_NextPart_001_01C667B7.DB2CDD9F--
