Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbVILW5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVILW5D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 18:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbVILW5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 18:57:03 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:14780 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750769AbVILW5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 18:57:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type;
        b=Uadk9mPkOryt2HHUHn+zGit/qmNKTHZh7yVzzlh2V7EzrgZCoB78qKU9k8vPuu6ctuTlsqX1/FC5DD/xujhnVZg2yI7F58mS7DHVx9LuG0zsOkgC5MUPoNOnfuqyqF1y3TiXybn3Gcu3a2tcEcH/Wb6IHyknef2gR2hdn6QJts8=
Message-ID: <432607B4.6080009@gmail.com>
Date: Tue, 13 Sep 2005 00:56:52 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       alexn@telia.com
Subject: Re: 2.6.13-mm3 [OOPS] vfs, page_owner, full reproductively, badness
 in vsnprintf
References: <20050912024350.60e89eb1.akpm@osdl.org>	<6bffcb0e050912044856628995@mail.gmail.com>	<20050912175433.GA8574@localhost.localdomain>	<6bffcb0e05091214133c189d05@mail.gmail.com> <20050912154428.7026eff7.akpm@osdl.org>
In-Reply-To: <20050912154428.7026eff7.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------050306050807090600010305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050306050807090600010305
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Andrew Morton napisał(a):
> Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> 
>>Hi,

>>Thanks, patch solved problem.
> 
> 
> Thanks.
> 
> 
>>Here is version, that clean apply on 2.6.13-mm3. Can you review it?
> 
> 
> That patch is all wordwrapped.

Ups, sorry. This should be good.
> 
> How doe sit differe from Alex's patch?
> 
> 

Alex's patch doesn't apply clean on 2.6.13-mm3.

Regards,
Michal Piotrowski

diff -uprN -X linux-mm-clean/Documentation/dontdiff 
linux-mm-clean/fs/proc/proc_misc.c linux-mm/fs/proc/proc_misc.c
--- linux-mm-clean/fs/proc/proc_misc.c	2005-09-12 23:02:10.000000000 +0200
+++ linux-mm/fs/proc/proc_misc.c	2005-09-12 22:52:51.000000000 +0200
@@ -567,6 +567,7 @@ read_page_owner(struct file *file, char
  	char namebuf[128];
  	unsigned long offset = 0, symsize;
  	int i;
+	ssize_t num_written = 0;

  	pfn = min_low_pfn + *ppos;
  	page = pfn_to_page(pfn);
@@ -587,23 +588,41 @@ read_page_owner(struct file *file, char
  	kbuf = kmalloc(count, GFP_KERNEL);
  	if (!kbuf)
  		return -ENOMEM;
+        ret = snprintf(kbuf, count, "Page allocated via order %d, mask 
0x%x\n",                        page->order, page->gfp_mask);
+        if (ret >= count) {
+                ret = -ENOMEM;
+                goto out;
+        }
+
+        num_written = ret;

-	ret = snprintf(kbuf, 1024, "Page allocated via order %d, mask 0x%x\n",
-			page->order, page->gfp_mask);

  	for (i = 0; i < 8; i++) {
  		if (!page->trace[i])
  			break;
  		symname = kallsyms_lookup(page->trace[i], &symsize, &offset, 
&modname, namebuf);
-		ret += snprintf(kbuf + ret, count - ret, "[0x%lx] %s+%lu\n",
+                ret = snprintf(kbuf + num_written, count - num_written, 
"[0x%lx] %s+%lu\n",
  			page->trace[i], namebuf, offset);
+                if (ret >= count - num_written) {
+                        ret = -ENOMEM;
+                        goto out;
+                }
+                num_written += ret;
+
  	}
+        ret = snprintf(kbuf + num_written, count - num_written, "\n");
+        if (ret >= count - num_written) {
+                ret = -ENOMEM;
+                goto out;
+        }

-	ret += snprintf(kbuf + ret, count -ret, "\n");
+        num_written += ret;
+        ret = num_written;

  	if (copy_to_user(buf, kbuf, ret))
  		ret = -EFAULT;

+out:
  	kfree(kbuf);
  	return ret;
  }

--------------050306050807090600010305
Content-Type: text/plain;
 name="proc_misc.c.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="proc_misc.c.diff"

ZGlmZiAtdXByTiAtWCBsaW51eC1tbS1jbGVhbi9Eb2N1bWVudGF0aW9uL2RvbnRkaWZmIGxp
bnV4LW1tLWNsZWFuL2ZzL3Byb2MvcHJvY19taXNjLmMgbGludXgtbW0vZnMvcHJvYy9wcm9j
X21pc2MuYwotLS0gbGludXgtbW0tY2xlYW4vZnMvcHJvYy9wcm9jX21pc2MuYwkyMDA1LTA5
LTEyIDIzOjAyOjEwLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtbW0vZnMvcHJvYy9wcm9j
X21pc2MuYwkyMDA1LTA5LTEyIDIyOjUyOjUxLjAwMDAwMDAwMCArMDIwMApAQCAtNTY3LDYg
KzU2Nyw3IEBAIHJlYWRfcGFnZV9vd25lcihzdHJ1Y3QgZmlsZSAqZmlsZSwgY2hhciAKIAlj
aGFyIG5hbWVidWZbMTI4XTsKIAl1bnNpZ25lZCBsb25nIG9mZnNldCA9IDAsIHN5bXNpemU7
CiAJaW50IGk7CisJc3NpemVfdCBudW1fd3JpdHRlbiA9IDA7CiAKIAlwZm4gPSBtaW5fbG93
X3BmbiArICpwcG9zOwogCXBhZ2UgPSBwZm5fdG9fcGFnZShwZm4pOwpAQCAtNTg3LDIzICs1
ODgsNDEgQEAgcmVhZF9wYWdlX293bmVyKHN0cnVjdCBmaWxlICpmaWxlLCBjaGFyIAogCWti
dWYgPSBrbWFsbG9jKGNvdW50LCBHRlBfS0VSTkVMKTsKIAlpZiAoIWtidWYpCiAJCXJldHVy
biAtRU5PTUVNOworICAgICAgICByZXQgPSBzbnByaW50ZihrYnVmLCBjb3VudCwgIlBhZ2Ug
YWxsb2NhdGVkIHZpYSBvcmRlciAlZCwgbWFzayAweCV4XG4iLCAgICAgICAgICAgICAgICAg
ICAgICAgIHBhZ2UtPm9yZGVyLCBwYWdlLT5nZnBfbWFzayk7CisgICAgICAgIGlmIChyZXQg
Pj0gY291bnQpIHsKKyAgICAgICAgICAgICAgICByZXQgPSAtRU5PTUVNOworICAgICAgICAg
ICAgICAgIGdvdG8gb3V0OworICAgICAgICB9CisKKyAgICAgICAgbnVtX3dyaXR0ZW4gPSBy
ZXQ7CiAKLQlyZXQgPSBzbnByaW50ZihrYnVmLCAxMDI0LCAiUGFnZSBhbGxvY2F0ZWQgdmlh
IG9yZGVyICVkLCBtYXNrIDB4JXhcbiIsCi0JCQlwYWdlLT5vcmRlciwgcGFnZS0+Z2ZwX21h
c2spOwogCiAJZm9yIChpID0gMDsgaSA8IDg7IGkrKykgewogCQlpZiAoIXBhZ2UtPnRyYWNl
W2ldKQogCQkJYnJlYWs7CiAJCXN5bW5hbWUgPSBrYWxsc3ltc19sb29rdXAocGFnZS0+dHJh
Y2VbaV0sICZzeW1zaXplLCAmb2Zmc2V0LCAmbW9kbmFtZSwgbmFtZWJ1Zik7Ci0JCXJldCAr
PSBzbnByaW50ZihrYnVmICsgcmV0LCBjb3VudCAtIHJldCwgIlsweCVseF0gJXMrJWx1XG4i
LAorICAgICAgICAgICAgICAgIHJldCA9IHNucHJpbnRmKGtidWYgKyBudW1fd3JpdHRlbiwg
Y291bnQgLSBudW1fd3JpdHRlbiwgIlsweCVseF0gJXMrJWx1XG4iLAogCQkJcGFnZS0+dHJh
Y2VbaV0sIG5hbWVidWYsIG9mZnNldCk7CisgICAgICAgICAgICAgICAgaWYgKHJldCA+PSBj
b3VudCAtIG51bV93cml0dGVuKSB7CisgICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAt
RU5PTUVNOworICAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXQ7CisgICAgICAgICAg
ICAgICAgfQorICAgICAgICAgICAgICAgIG51bV93cml0dGVuICs9IHJldDsKKwogCX0KKyAg
ICAgICAgcmV0ID0gc25wcmludGYoa2J1ZiArIG51bV93cml0dGVuLCBjb3VudCAtIG51bV93
cml0dGVuLCAiXG4iKTsKKyAgICAgICAgaWYgKHJldCA+PSBjb3VudCAtIG51bV93cml0dGVu
KSB7CisgICAgICAgICAgICAgICAgcmV0ID0gLUVOT01FTTsKKyAgICAgICAgICAgICAgICBn
b3RvIG91dDsKKyAgICAgICAgfQogCi0JcmV0ICs9IHNucHJpbnRmKGtidWYgKyByZXQsIGNv
dW50IC1yZXQsICJcbiIpOworICAgICAgICBudW1fd3JpdHRlbiArPSByZXQ7CisgICAgICAg
IHJldCA9IG51bV93cml0dGVuOwogCiAJaWYgKGNvcHlfdG9fdXNlcihidWYsIGtidWYsIHJl
dCkpCiAJCXJldCA9IC1FRkFVTFQ7CiAKK291dDoKIAlrZnJlZShrYnVmKTsKIAlyZXR1cm4g
cmV0OwogfQo=
--------------050306050807090600010305--
