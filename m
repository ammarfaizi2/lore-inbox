Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWEVAJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWEVAJS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 20:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWEVAJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 20:09:18 -0400
Received: from smtpq3.tilbu1.nb.home.nl ([213.51.146.202]:11718 "EHLO
	smtpq3.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S964956AbWEVAJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 20:09:17 -0400
Message-ID: <44710162.3070406@keyaccess.nl>
Date: Mon, 22 May 2006 02:10:10 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.17-rc2+ regression -- audio skipping
References: <4470CC8F.9030706@keyaccess.nl> <1148247047.20472.78.camel@mindpipe>
In-Reply-To: <1148247047.20472.78.camel@mindpipe>
Content-Type: multipart/mixed;
 boundary="------------020706010703030706070708"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020706010703030706070708
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Lee Revell wrote:

> On Sun, 2006-05-21 at 22:24 +0200, Rene Herman wrote:

>> 2.6.17-rc2 (and 3 and 4) make my audio skip. Audio player is ogg123 
>> running in an xterm. Browsing heavy sites (say, eBay) with Firefox 
>> 1.5.0.3 gets me audio underruns quickly. This does not happen on 
>> 2.6.17-rc1 and earlier (I just tested extensively; quite impossible to 
>> generate underruns on -rc1, quickly on -rc2 and later).
>>
>> It's not ALSA; reverted */sound/* from the rc1-rc2 interdiff. It's also 
>> not cfq-iosched.c. Any likely culprits in there? (I'm not a GIT user).
>>
> 
> I would suspect the scheduler interactivity patches.  Please confirm
> this by running ogg123 at nice -20 - do the underruns persist?

They do persist. Thanks for the hint though -- "sched: fix interactive 
task starvation" is the culprit:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=5ce74abe788a26698876e66b9c9ce7e7acc25413

Added author and acked-by's to the CC. Mike, this patch is no good for 
me. Audio underruns galore, with only ogg123 and firefox (browsing the 
GIT tree online is also a nice trigger by the way).

If I back it out, everything is fine for me again. Back-out attached as 
a patch against -rc4. This also backs out your follow-up "don't awaken 
RT tasks on expired array" as it was dependant:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8a5bc075b8d8cf7a87b3f08fad2fba0f5d13295e

While looking at the patch I noticed there was +1 difference in the 
"limit" value between the macro and the static inline version of 
expired_starving() so I experimented with adding that back but that 
wasn't it unfortunately.

I can test patches (preferably versus -rc4) although possibly not quickly.

Rene.


--------------020706010703030706070708
Content-Type: text/plain;
 name="unfix_interactive_task_starvation.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="unfix_interactive_task_starvation.diff"

SW5kZXg6IGxvY2FsL2tlcm5lbC9zY2hlZC5jCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxvY2FsLm9y
aWcva2VybmVsL3NjaGVkLmMJMjAwNi0wNS0wOCAyMDo0NzowNi4wMDAwMDAwMDAgKzAyMDAK
KysrIGxvY2FsL2tlcm5lbC9zY2hlZC5jCTIwMDYtMDUtMjIgMDE6MDM6MTIuMDAwMDAwMDAw
ICswMjAwCkBAIC02NjUsNTUgKzY2NSwxMyBAQCBzdGF0aWMgaW50IGVmZmVjdGl2ZV9wcmlv
KHRhc2tfdCAqcCkKIH0KIAogLyoKLSAqIFdlIHBsYWNlIGludGVyYWN0aXZlIHRhc2tzIGJh
Y2sgaW50byB0aGUgYWN0aXZlIGFycmF5LCBpZiBwb3NzaWJsZS4KLSAqCi0gKiBUbyBndWFy
YW50ZWUgdGhhdCB0aGlzIGRvZXMgbm90IHN0YXJ2ZSBleHBpcmVkIHRhc2tzIHdlIGlnbm9y
ZSB0aGUKLSAqIGludGVyYWN0aXZpdHkgb2YgYSB0YXNrIGlmIHRoZSBmaXJzdCBleHBpcmVk
IHRhc2sgaGFkIHRvIHdhaXQgbW9yZQotICogdGhhbiBhICdyZWFzb25hYmxlJyBhbW91bnQg
b2YgdGltZS4gVGhpcyBkZWFkbGluZSB0aW1lb3V0IGlzCi0gKiBsb2FkLWRlcGVuZGVudCwg
YXMgdGhlIGZyZXF1ZW5jeSBvZiBhcnJheSBzd2l0Y2hlZCBkZWNyZWFzZXMgd2l0aAotICog
aW5jcmVhc2luZyBudW1iZXIgb2YgcnVubmluZyB0YXNrcy4gV2UgYWxzbyBpZ25vcmUgdGhl
IGludGVyYWN0aXZpdHkKLSAqIGlmIGEgYmV0dGVyIHN0YXRpY19wcmlvIHRhc2sgaGFzIGV4
cGlyZWQsIGFuZCBzd2l0Y2ggcGVyaW9kaWNhbGx5Ci0gKiByZWdhcmRsZXNzLCB0byBlbnN1
cmUgdGhhdCBoaWdobHkgaW50ZXJhY3RpdmUgdGFza3MgZG8gbm90IHN0YXJ2ZQotICogdGhl
IGxlc3MgZm9ydHVuYXRlIGZvciB1bnJlYXNvbmFibHkgbG9uZyBwZXJpb2RzLgotICovCi1z
dGF0aWMgaW5saW5lIGludCBleHBpcmVkX3N0YXJ2aW5nKHJ1bnF1ZXVlX3QgKnJxKQotewot
CWludCBsaW1pdDsKLQotCS8qCi0JICogQXJyYXlzIHdlcmUgcmVjZW50bHkgc3dpdGNoZWQs
IGFsbCBpcyB3ZWxsCi0JICovCi0JaWYgKCFycS0+ZXhwaXJlZF90aW1lc3RhbXApCi0JCXJl
dHVybiAwOwotCi0JbGltaXQgPSBTVEFSVkFUSU9OX0xJTUlUICogcnEtPm5yX3J1bm5pbmc7
Ci0KLQkvKgotCSAqIEl0J3MgdGltZSB0byBzd2l0Y2ggYXJyYXlzCi0JICovCi0JaWYgKGpp
ZmZpZXMgLSBycS0+ZXhwaXJlZF90aW1lc3RhbXAgPj0gbGltaXQpCi0JCXJldHVybiAxOwot
Ci0JLyoKLQkgKiBUaGVyZSdzIGEgYmV0dGVyIHNlbGVjdGlvbiBpbiB0aGUgZXhwaXJlZCBh
cnJheQotCSAqLwotCWlmIChycS0+Y3Vyci0+c3RhdGljX3ByaW8gPiBycS0+YmVzdF9leHBp
cmVkX3ByaW8pCi0JCXJldHVybiAxOwotCi0JLyoKLQkgKiBBbGwgaXMgd2VsbAotCSAqLwot
CXJldHVybiAwOwotfQotCi0vKgogICogX19hY3RpdmF0ZV90YXNrIC0gbW92ZSBhIHRhc2sg
dG8gdGhlIHJ1bnF1ZXVlLgogICovCiBzdGF0aWMgdm9pZCBfX2FjdGl2YXRlX3Rhc2sodGFz
a190ICpwLCBydW5xdWV1ZV90ICpycSkKIHsKIAlwcmlvX2FycmF5X3QgKnRhcmdldCA9IHJx
LT5hY3RpdmU7CiAKLQlpZiAodW5saWtlbHkoYmF0Y2hfdGFzayhwKSB8fCAoZXhwaXJlZF9z
dGFydmluZyhycSkgJiYgIXJ0X3Rhc2socCkpKSkKKwlpZiAoYmF0Y2hfdGFzayhwKSkKIAkJ
dGFyZ2V0ID0gcnEtPmV4cGlyZWQ7CiAJZW5xdWV1ZV90YXNrKHAsIHRhcmdldCk7CiAJcnEt
Pm5yX3J1bm5pbmcrKzsKQEAgLTI1MzIsNiArMjQ5MCwyMiBAQCB1bnNpZ25lZCBsb25nIGxv
bmcgY3VycmVudF9zY2hlZF90aW1lKGNvCiB9CiAKIC8qCisgKiBXZSBwbGFjZSBpbnRlcmFj
dGl2ZSB0YXNrcyBiYWNrIGludG8gdGhlIGFjdGl2ZSBhcnJheSwgaWYgcG9zc2libGUuCisg
KgorICogVG8gZ3VhcmFudGVlIHRoYXQgdGhpcyBkb2VzIG5vdCBzdGFydmUgZXhwaXJlZCB0
YXNrcyB3ZSBpZ25vcmUgdGhlCisgKiBpbnRlcmFjdGl2aXR5IG9mIGEgdGFzayBpZiB0aGUg
Zmlyc3QgZXhwaXJlZCB0YXNrIGhhZCB0byB3YWl0IG1vcmUKKyAqIHRoYW4gYSAncmVhc29u
YWJsZScgYW1vdW50IG9mIHRpbWUuIFRoaXMgZGVhZGxpbmUgdGltZW91dCBpcworICogbG9h
ZC1kZXBlbmRlbnQsIGFzIHRoZSBmcmVxdWVuY3kgb2YgYXJyYXkgc3dpdGNoZWQgZGVjcmVh
c2VzIHdpdGgKKyAqIGluY3JlYXNpbmcgbnVtYmVyIG9mIHJ1bm5pbmcgdGFza3MuIFdlIGFs
c28gaWdub3JlIHRoZSBpbnRlcmFjdGl2aXR5CisgKiBpZiBhIGJldHRlciBzdGF0aWNfcHJp
byB0YXNrIGhhcyBleHBpcmVkOgorICovCisjZGVmaW5lIEVYUElSRURfU1RBUlZJTkcocnEp
IFwKKwkoKFNUQVJWQVRJT05fTElNSVQgJiYgKChycSktPmV4cGlyZWRfdGltZXN0YW1wICYm
IFwKKwkJKGppZmZpZXMgLSAocnEpLT5leHBpcmVkX3RpbWVzdGFtcCA+PSBcCisJCQlTVEFS
VkFUSU9OX0xJTUlUICogKChycSktPm5yX3J1bm5pbmcpICsgMSkpKSB8fCBcCisJCQkoKHJx
KS0+Y3Vyci0+c3RhdGljX3ByaW8gPiAocnEpLT5iZXN0X2V4cGlyZWRfcHJpbykpCisKKy8q
CiAgKiBBY2NvdW50IHVzZXIgY3B1IHRpbWUgdG8gYSBwcm9jZXNzLgogICogQHA6IHRoZSBw
cm9jZXNzIHRoYXQgdGhlIGNwdSB0aW1lIGdldHMgYWNjb3VudGVkIHRvCiAgKiBAaGFyZGly
cV9vZmZzZXQ6IHRoZSBvZmZzZXQgdG8gc3VidHJhY3QgZnJvbSBoYXJkaXJxX2NvdW50KCkK
QEAgLTI2NjYsNyArMjY0MCw3IEBAIHZvaWQgc2NoZWR1bGVyX3RpY2sodm9pZCkKIAogCQlp
ZiAoIXJxLT5leHBpcmVkX3RpbWVzdGFtcCkKIAkJCXJxLT5leHBpcmVkX3RpbWVzdGFtcCA9
IGppZmZpZXM7Ci0JCWlmICghVEFTS19JTlRFUkFDVElWRShwKSB8fCBleHBpcmVkX3N0YXJ2
aW5nKHJxKSkgeworCQlpZiAoIVRBU0tfSU5URVJBQ1RJVkUocCkgfHwgRVhQSVJFRF9TVEFS
VklORyhycSkpIHsKIAkJCWVucXVldWVfdGFzayhwLCBycS0+ZXhwaXJlZCk7CiAJCQlpZiAo
cC0+c3RhdGljX3ByaW8gPCBycS0+YmVzdF9leHBpcmVkX3ByaW8pCiAJCQkJcnEtPmJlc3Rf
ZXhwaXJlZF9wcmlvID0gcC0+c3RhdGljX3ByaW87Cg==
--------------020706010703030706070708--
