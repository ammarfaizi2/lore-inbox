Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVAYEyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVAYEyX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 23:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVAYEyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 23:54:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:22704 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261813AbVAYEu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 23:50:56 -0500
From: Andrew Tridgell <tridge@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SboTgP6p8B"
Content-Transfer-Encoding: 7bit
Message-ID: <16885.53121.883933.986880@samba.org>
Date: Tue, 25 Jan 2005 15:48:01 +1100
To: "Randy.Dunlap" <rddunlap@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: memory leak in 2.6.11-rc2
In-Reply-To: <16885.48502.243516.563660@samba.org>
References: <20050120020124.110155000@suse.de>
	<16884.8352.76012.779869@samba.org>
	<200501232358.09926.agruen@suse.de>
	<200501240032.17236.agruen@suse.de>
	<16884.56071.773949.280386@samba.org>
	<16885.47804.68041.144011@samba.org>
	<41F5BB0D.6090006@osdl.org>
	<16885.48502.243516.563660@samba.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SboTgP6p8B
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

 > I'm trying the little leak tracking patch from Alexander Nyberg now.

Here are the results (only backtraces with more than 10k counts
included). The leak was at 1G of memory at the time I ran this, so its
safe to say 10k page allocations ain't enough to explain it :-)

I also attach a hacked version of the pgown sort program that sorts
the output by count, and isn't O(n^2). It took 10 minutes to run the
old version :-)

I'm guessing the leak is in the new xattr code given that is what
dbench and nbench were beating on. Andreas, can you look at the
following and see if you can spot anything?

This was on 2.6.11-rc2 with the pipe leak patch from Linus. The
machine had leaked 1G of ram in 10 minutes, and was idle (only thing
running was sshd).

Cheers, Tridge


175485 times:
Page allocated via order 0
[0xc0132258] generic_file_buffered_write+280
[0xc011b6a9] current_fs_time+77
[0xc0132a1e] __generic_file_aio_write_nolock+642
[0xc0132e70] generic_file_aio_write+100
[0xc017e586] ext3_file_write+38
[0xc014b7f5] do_sync_write+169
[0xc015f6de] fcntl_setlk64+286
[0xc01295a8] autoremove_wake_function+0

141512 times:
Page allocated via order 0
[0xc0132258] generic_file_buffered_write+280
[0xc0132a1e] __generic_file_aio_write_nolock+642
[0xc0132e70] generic_file_aio_write+100
[0xc017e586] ext3_file_write+38
[0xc014b7f5] do_sync_write+169
[0xc015f6de] fcntl_setlk64+286
[0xc01295a8] autoremove_wake_function+0
[0xc014b8d5] vfs_write+157

67641 times:
Page allocated via order 0
[0xc0132258] generic_file_buffered_write+280
[0xc014dc69] __getblk+29
[0xc011b6a9] current_fs_time+77
[0xc0132a1e] __generic_file_aio_write_nolock+642
[0xc018d368] ext3_xattr_user_get+108
[0xc0132e70] generic_file_aio_write+100
[0xc017e586] ext3_file_write+38
[0xc014b7f5] do_sync_write+169

52758 times:
Page allocated via order 0
[0xc0132258] generic_file_buffered_write+280
[0xc014dc69] __getblk+29
[0xc0132a1e] __generic_file_aio_write_nolock+642
[0xc018d368] ext3_xattr_user_get+108
[0xc0132e70] generic_file_aio_write+100
[0xc017e586] ext3_file_write+38
[0xc014b7f5] do_sync_write+169
[0xc0120c0b] kill_proc_info+47

19610 times:
Page allocated via order 0
[0xc0132258] generic_file_buffered_write+280
[0xc011b6a9] current_fs_time+77
[0xc0132a1e] __generic_file_aio_write_nolock+642
[0xc0132c3a] generic_file_aio_write_nolock+54
[0xc0132def] generic_file_write_nolock+151
[0xc011b7cb] __do_softirq+95
[0xc01295a8] autoremove_wake_function+0
[0xc01295a8] autoremove_wake_function+0

16874 times:
Page allocated via order 0
[0xc0132258] generic_file_buffered_write+280
[0xc011b6a9] current_fs_time+77
[0xc0132a1e] __generic_file_aio_write_nolock+642
[0xc0132c3a] generic_file_aio_write_nolock+54
[0xc0132def] generic_file_write_nolock+151
[0xc01295a8] autoremove_wake_function+0
[0xc01295a8] autoremove_wake_function+0
[0xc0152d4a] blkdev_file_write+38


--SboTgP6p8B
Content-Type: application/octet-stream
Content-Disposition: attachment;
	filename="pgown-fast.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN5cy90eXBl
cy5oPgojaW5jbHVkZSA8c3lzL3N0YXQuaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDx1
bmlzdGQuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgoKc3RydWN0IGJsb2NrX2xpc3QgewoJY2hhciAq
dHh0OwoJaW50IGxlbjsKCWludCBudW07Cn07CgoKc3RhdGljIHN0cnVjdCBibG9ja19saXN0ICps
aXN0OwpzdGF0aWMgaW50IGxpc3Rfc2l6ZTsKc3RhdGljIGludCBtYXhfc2l6ZTsKCnN0cnVjdCBi
bG9ja19saXN0ICpibG9ja19oZWFkOwoKaW50IHJlYWRfYmxvY2soY2hhciAqYnVmLCBGSUxFICpm
aW4pCnsKCWludCByZXQgPSAwOwoJaW50IGhpdCA9IDA7CgljaGFyICpjdXJyID0gYnVmOwoJCglm
b3IgKDs7KSB7CgkJKmN1cnIgPSBnZXRjKGZpbik7CgkJaWYgKCpjdXJyID09IEVPRikgcmV0dXJu
IC0xOwoJCQoJCXJldCsrOwoJCWlmICgqY3VyciA9PSAnXG4nICYmIGhpdCA9PSAxKQoJCQlyZXR1
cm4gcmV0IC0gMTsKCQllbHNlIGlmICgqY3VyciA9PSAnXG4nKQoJCQloaXQgPSAxOwoJCWVsc2UK
CQkJaGl0ID0gMDsKCQljdXJyKys7Cgl9Cn0KCnN0YXRpYyBpbnQgY29tcGFyZV90eHQoc3RydWN0
IGJsb2NrX2xpc3QgKmwxLCBzdHJ1Y3QgYmxvY2tfbGlzdCAqbDIpCnsKCXJldHVybiBzdHJjbXAo
bDEtPnR4dCwgbDItPnR4dCk7Cn0KCnN0YXRpYyBpbnQgY29tcGFyZV9udW0oc3RydWN0IGJsb2Nr
X2xpc3QgKmwxLCBzdHJ1Y3QgYmxvY2tfbGlzdCAqbDIpCnsKCXJldHVybiBsMi0+bnVtIC0gbDEt
Pm51bTsKfQoKc3RhdGljIHZvaWQgYWRkX2xpc3QoY2hhciAqYnVmLCBpbnQgbGVuKQp7CglpZiAo
bGlzdF9zaXplICE9IDAgJiYKCSAgICBsZW4gPT0gbGlzdFtsaXN0X3NpemUtMV0ubGVuICYmCgkg
ICAgbWVtY21wKGJ1ZiwgbGlzdFtsaXN0X3NpemUtMV0udHh0LCBsZW4pID09IDApIHsKCQlsaXN0
W2xpc3Rfc2l6ZS0xXS5udW0rKzsKCQlyZXR1cm47Cgl9CglpZiAobGlzdF9zaXplID09IG1heF9z
aXplKSB7CgkJcHJpbnRmKCJtYXhfc2l6ZSB0b28gc21hbGw/P1xuIik7CgkJZXhpdCgxKTsKCX0K
CWxpc3RbbGlzdF9zaXplXS50eHQgPSBtYWxsb2MobGVuKzEpOwoJbGlzdFtsaXN0X3NpemVdLmxl
biA9IGxlbjsKCWxpc3RbbGlzdF9zaXplXS5udW0gPSAxOwoJbWVtY3B5KGxpc3RbbGlzdF9zaXpl
XS50eHQsIGJ1ZiwgbGVuKTsKCWxpc3RbbGlzdF9zaXplXS50eHRbbGVuXSA9IDA7CglsaXN0X3Np
emUrKzsKCWlmIChsaXN0X3NpemUgJSAxMDAwID09IDApIHsKCQlwcmludGYoImxvYWRlZCAlZFxy
IiwgbGlzdF9zaXplKTsKCQlmZmx1c2goc3Rkb3V0KTsKCX0KfQoKaW50IG1haW4oaW50IGFyZ2Ms
IGNoYXIgKiphcmd2KQp7CglGSUxFICpmaW4sICpmb3V0OwoJY2hhciBidWZbMTAyNF07CglpbnQg
cmV0LCBpLCBjb3VudDsKCXN0cnVjdCBibG9ja19saXN0ICpsaXN0MjsKCXN0cnVjdCBzdGF0IHN0
OwoJCglmaW4gPSBmb3Blbihhcmd2WzFdLCAiciIpOwoJZm91dCA9IGZvcGVuKGFyZ3ZbMl0sICJ3
Iik7CglpZiAoIWZpbiB8fCAhZm91dCkgewoJCXByaW50ZigiVXNhZ2U6IC4vcHJvZ3JhbSA8aW5w
dXQ+IDxvdXRwdXQ+XG4iKTsKCQlwZXJyb3IoIm9wZW46ICIpOwoJCWV4aXQoMik7Cgl9CgoJZnN0
YXQoZmlsZW5vKGZpbiksICZzdCk7CgltYXhfc2l6ZSA9IHN0LnN0X3NpemUgLyAxMDA7IC8qIGhh
Y2sgLi4uICovCgoJbGlzdCA9IG1hbGxvYyhtYXhfc2l6ZSAqIHNpemVvZigqbGlzdCkpOwoJCglm
b3IoOzspIHsKCQlyZXQgPSByZWFkX2Jsb2NrKGJ1ZiwgZmluKTsKCQlpZiAocmV0IDwgMCkKCQkJ
YnJlYWs7CgkJCgkJYnVmW3JldF0gPSAnXDAnOwoJCWFkZF9saXN0KGJ1ZiwgcmV0KTsKCX0KCglw
cmludGYoImxvYWRlZCAlZFxuIiwgbGlzdF9zaXplKTsKCglwcmludGYoInNvcnRpbmcgLi4uLlxu
Iik7CgoJcXNvcnQobGlzdCwgbGlzdF9zaXplLCBzaXplb2YobGlzdFswXSksIGNvbXBhcmVfdHh0
KTsKCglsaXN0MiA9IG1hbGxvYyhzaXplb2YoKmxpc3QpICogbGlzdF9zaXplKTsKCglwcmludGYo
ImN1bGxpbmdcbiIpOwoKCWZvciAoaT1jb3VudD0wO2k8bGlzdF9zaXplO2krKykgewoJCWlmIChj
b3VudCA9PSAwIHx8IAoJCSAgICBzdHJjbXAobGlzdDJbY291bnQtMV0udHh0LCBsaXN0W2ldLnR4
dCkgIT0gMCkgewoJCQlsaXN0Mltjb3VudCsrXSA9IGxpc3RbaV07CgkJfSBlbHNlIHsKCQkJbGlz
dDJbY291bnQtMV0ubnVtICs9IGxpc3RbaV0ubnVtOwoJCX0KCX0KCQoJcXNvcnQobGlzdDIsIGNv
dW50LCBzaXplb2YobGlzdFswXSksIGNvbXBhcmVfbnVtKTsKCQoJZm9yIChpPTA7aTxjb3VudDtp
KyspIHsKCQlmcHJpbnRmKGZvdXQsICIlZCB0aW1lczpcbiVzXG4iLCBsaXN0MltpXS5udW0sIGxp
c3QyW2ldLnR4dCk7Cgl9CglyZXR1cm4gMDsKfQoKCgoK
--SboTgP6p8B--
