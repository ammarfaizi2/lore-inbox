Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWIVTsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWIVTsu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 15:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWIVTst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 15:48:49 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:6829 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964834AbWIVTst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 15:48:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:x-google-sender-auth;
        b=E0G5h6bbZAbDwO8KI+PsASIhlI6mF5rDDW6r5lsdCgZVW695hMUdwoSwA8pBS0WpifR9paQtZE5BvFTeBu77ETlUuoevreQ1jy9T3BZl9U9u4JN2rijPQAHi3kBb5OCFeU3ftCiZcj95YMxoNSxA8qQko/1epVjiRC346X5KJhc=
Message-ID: <c1bf1cf0609221248v39113875id4b48c62cec8eb46@mail.gmail.com>
Date: Fri, 22 Sep 2006 12:48:48 -0700
From: "Ed Swierk" <eswierk@arastra.com>
To: linux-kernel@vger.kernel.org
Subject: [RETRY] [PATCH] load_module: no BUG if module_subsys uninitialized
Cc: rusty@rustcorp.com.au
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_32997_30962540.1158954528426"
X-Google-Sender-Auth: 2527b6b82e42a772
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_32997_30962540.1158954528426
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[I discovered after sending my previous message that Gmail helpfully
line-wrapped and de-tabified my patch. I'm resending it as an
attachment; apologies for the error.]

Invoking load_module() before param_sysfs_init() is called crashes in
mod_sysfs_setup(), since the kset in module_subsys is not initialized
yet.

Another patch for the same symptom
(module_subsys-initialize-earlier.patch) moves param_sysfs_init() to
the subsys initcalls, but this is still not early enough in the boot
process in some cases. In particular, topology_init() causes
/sbin/hotplug to run, which requests net-pf-1 (the UNIX socket
protocol) which can be compiled as a module. Moving param_sysfs_init()
to the postcore initcalls fixes this particular race, but there might
well be other cases where a usermodehelper causes a module to load
earlier still.

The patch below makes load_module() return an error rather than
crashing the kernel if invoked before module_subsys is initialized.

------=_Part_32997_30962540.1158954528426
Content-Type: text/x-patch; name=module_subsys-uninit-return-err.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_esezk7xt
Content-Disposition: attachment; filename="module_subsys-uninit-return-err.patch"

LS0tIGxpbnV4LTIuNi4xNy4xMS5vcmlnL2tlcm5lbC9tb2R1bGUuYwkyMDA2LTA4LTIzIDIxOjE2
OjMzLjAwMDAwMDAwMCArMDAwMAorKysgbGludXgtMi42LjE3LjExL2tlcm5lbC9tb2R1bGUuYwky
MDA2LTA5LTIyIDA1OjE5OjAzLjAwMDAwMDAwMCArMDAwMApAQCAtOTk4LDYgKzk5OCwxMiBAQAog
ewogCWludCBlcnI7CiAKKwlpZiAoIW1vZHVsZV9zdWJzeXMua3NldC5zdWJzeXMpIHsKKwkJcHJp
bnRrKEtFUk5fRVJSICIlczogbW9kdWxlX3N1YnN5cyBub3QgaW5pdGlhbGl6ZWRcbiIsCisJCSAg
ICAgICBtb2QtPm5hbWUpOworCQllcnIgPSAtRUlOVkFMOworCQlnb3RvIG91dDsKKwl9CiAJbWVt
c2V0KCZtb2QtPm1rb2JqLmtvYmosIDAsIHNpemVvZihtb2QtPm1rb2JqLmtvYmopKTsKIAllcnIg
PSBrb2JqZWN0X3NldF9uYW1lKCZtb2QtPm1rb2JqLmtvYmosICIlcyIsIG1vZC0+bmFtZSk7CiAJ
aWYgKGVycikK
------=_Part_32997_30962540.1158954528426--
