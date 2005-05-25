Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbVEYGzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbVEYGzU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 02:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbVEYGx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 02:53:56 -0400
Received: from ns1.suse.de ([195.135.220.2]:6116 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262299AbVEYGuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 02:50:12 -0400
Message-ID: <4294201D.4070304@suse.de>
Date: Wed, 25 May 2005 08:50:05 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix reference counting for failed SCSI devices
References: <4292F631.9090300@suse.de> <1116975478.7710.28.camel@mulgrave>
In-Reply-To: <1116975478.7710.28.camel@mulgrave>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010702080109080404020302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010702080109080404020302
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

James Bottomley wrote:
> On Tue, 2005-05-24 at 11:38 +0200, Hannes Reinecke wrote:
>>whenever the scsi-ml tries to scan non-existent devices the reference
>>count in scsi_alloc_sdev() and scsi_probe_and_add_lun() is not adjusted
>>properly. Every call to XXX_initialize in the driver core sets the
>>reference count to 1, so for a proper deallocation an explicit XXX_put()
>>has to be done.
> 
> That's true, but I don't see what the problem is if the device has never
> been made visible.
> 
It's not visible but it's still allocated and referenced. So on doing a
rmmod these class_devices are being deallocated which crashes as the
class device is not connected properly.

>>+			put_device(&starget->dev);
> 
> this would amount to a double put, since the parent put method is called
> in the device release.
> 
Oops. Correct.

>>+	class_device_put(&sdev->sdev_classdev);
> 
> This is unnecessary since the class device is simply occupying a private
> area in the scsi_device.  As long as its never made visible to the
> system, its refcount is irrelevant
> 
It's not. Whenever you try to rmmod the adapter it becomes highly
relevant. If it doesn't crash you've at least generated a memleak as the
class device is never freed.
(And these are quite a few for Wide-SCSI Double-channel adapters ...)

>> 	put_device(&sdev->sdev_gendev);
>> out:
>> 	if (display_failure_msg)
>>@@ -855,6 +857,8 @@ static int scsi_probe_and_add_lun(struct
>> 		if (sdev->host->hostt->slave_destroy)
>> 			sdev->host->hostt->slave_destroy(sdev);
>> 		transport_destroy_device(&sdev->sdev_gendev);
>>+		class_device_put(&sdev->sdev_classdev);
>>+		put_device(sdev->sdev_gendev.parent);
> 
> same should apply here.  As long as this cascade occurs before
> scsi_add_lun() (which calls scsi_sysfs_add_sdev()), which is what makes
> the whole set of devices and classes visible.
> 
Correct for the parent device. The class device has to be deallocated
properly if a rmmod should work properly.

New patch attached. Please apply.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

--------------010702080109080404020302
Content-Type: text/plain;
 name="linux-2.6.12-rc4-scsi-scan-fix-refcount-on-fail"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="linux-2.6.12-rc4-scsi-scan-fix-refcount-on-fail"

RnJvbTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+ClN1YmplY3Q6IEZpeCByZWZj
b3VudCBmb3IgZmFpbGVkIGRldmljZXMKCldoZW4gYSBub24tcHJlc2VudCBkZXZpY2UgaXMg
c2Nhbm5lZCBpdCBpcyBub3QgcHJvcGVybHkgZGVyZWdpc3RlcmVkCmZyb20gdGhlIGRyaXZl
ciBjb3JlLiBDYWxsaW5nIFhYWF9pbml0aWFsaXplKCkgZnVuY3Rpb25zIGZyb20gdGhlIGRy
aXZlcgpjb3JlIHNldHMgdGhlIHJlZmVyZW5jZSBjb3VudCB0byAxLCBzbyBmb3IgcHJvcGVy
IGRlYWxsb2NhdGlvbiBhClhYWF9wdXQoKSBoYXMgdG8gYmUgaXNzdWVkLgoKLS0tIGxpbnV4
LTIuNi4xMi1yYzQvZHJpdmVycy9zY3NpL3Njc2lfc2Nhbi5jLm9yaWcJMjAwNS0wNS0yNCAx
MDoyNjo0Ni4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4xMi1yYzQvZHJpdmVycy9z
Y3NpL3Njc2lfc2Nhbi5jCTIwMDUtMDUtMjQgMTA6NTU6NTIuMDAwMDAwMDAwICswMjAwCkBA
IC0yODIsNiArMjgyLDcgQEAgc3RhdGljIHN0cnVjdCBzY3NpX2RldmljZSAqc2NzaV9hbGxv
Y19zZAogb3V0X2RldmljZV9kZXN0cm95OgogCXRyYW5zcG9ydF9kZXN0cm95X2RldmljZSgm
c2Rldi0+c2Rldl9nZW5kZXYpOwogCXNjc2lfZnJlZV9xdWV1ZShzZGV2LT5yZXF1ZXN0X3F1
ZXVlKTsKKwljbGFzc19kZXZpY2VfcHV0KCZzZGV2LT5zZGV2X2NsYXNzZGV2KTsKIAlwdXRf
ZGV2aWNlKCZzZGV2LT5zZGV2X2dlbmRldik7CiBvdXQ6CiAJaWYgKGRpc3BsYXlfZmFpbHVy
ZV9tc2cpCkBAIC04NTUsNiArODU2LDcgQEAgc3RhdGljIGludCBzY3NpX3Byb2JlX2FuZF9h
ZGRfbHVuKHN0cnVjdAogCQlpZiAoc2Rldi0+aG9zdC0+aG9zdHQtPnNsYXZlX2Rlc3Ryb3kp
CiAJCQlzZGV2LT5ob3N0LT5ob3N0dC0+c2xhdmVfZGVzdHJveShzZGV2KTsKIAkJdHJhbnNw
b3J0X2Rlc3Ryb3lfZGV2aWNlKCZzZGV2LT5zZGV2X2dlbmRldik7CisJCWNsYXNzX2Rldmlj
ZV9wdXQoJnNkZXYtPnNkZXZfY2xhc3NkZXYpOwogCQlwdXRfZGV2aWNlKCZzZGV2LT5zZGV2
X2dlbmRldik7CiAJfQogIG91dDoK
--------------010702080109080404020302--
