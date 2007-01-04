Return-Path: <linux-kernel-owner+w=401wt.eu-S964961AbXADQ1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbXADQ1J (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbXADQ1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:27:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:1578 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964961AbXADQ1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:27:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=bUsU6EFsnvHzXnNKfNPMSdnZkbDQxAprXz0QKfArYyOhTbLI0WSLefic24oMA6GocykFy1qnUH5ipVrOv2iR3BVPiyLeYyVKCOg4spem3zvwWxITt06ViweIU1Yo6kQAIRnusauAGybGuygAKORWawwkHHi6wLjAZ8YAj8fGkwA=
Message-ID: <c70ff3ad0701040827n5551eb01sb62f65e493a810c8@mail.gmail.com>
Date: Thu, 4 Jan 2007 18:27:04 +0200
From: "saeed bishara" <saeed.bishara@gmail.com>
To: "Jens Axboe" <jens.axboe@oracle.com>
Subject: Re: using splice/vmsplice to improve file receive performance
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20070104141638.GB11203@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_8041_24038954.1167928024519"
References: <c70ff3ad0612211121g3c5aaa28s9b738e9c79f9c2be@mail.gmail.com>
	 <20061222094858.GP17199@kernel.dk>
	 <c70ff3ad0612220318i54e7569fn161cf781d9bf0669@mail.gmail.com>
	 <20061222113917.GQ17199@kernel.dk>
	 <c70ff3ad0612220359w3f568850qb720230bae76a698@mail.gmail.com>
	 <20061222124710.GR17199@kernel.dk>
	 <c70ff3ad0701031209g43cf5576v11b6409696af1ed4@mail.gmail.com>
	 <20070104140813.GZ11203@kernel.dk> <20070104141638.GB11203@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_8041_24038954.1167928024519
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 1/4/07, Jens Axboe <jens.axboe@oracle.com> wrote:
> On Thu, Jan 04 2007, Jens Axboe wrote:
> > On Wed, Jan 03 2007, saeed bishara wrote:
> > > On 12/22/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> > > >On Fri, Dec 22 2006, saeed bishara wrote:
> > > >> On 12/22/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> > > >> >On Fri, Dec 22 2006, saeed bishara wrote:
> > > >> >> On 12/22/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> > > >> >> >On Thu, Dec 21 2006, saeed bishara wrote:
> > > >> >> >> Hi,
> > > >> >> >> I'm trying to use the splice/vmsplice system calls to improve the
> > > >> >> >> samba server write throughput, but before touching the smbd, I
> > > >started
> > > >> >> >> to improve the ttcp tool since it simple and has the same flow. I'm
> > > >> >> >> expecting to avoid the "copy_from_user" path when using those
> > > >> >> >> syscalls.
> > > >> >> >> so far, I couldn't make any improvement, actually the throughput
> > > >get
> > > >> >> >> worst. the new receive flow looks like this (code also attached):
> > > >> >> >> 1. read tcp packet (64 pages) to page aligned buffer.
> > > >> >> >> 2. vmsplice the buffer to pipe with SPLICE_F_MOVE.
> > > >> >> >> 3. splice the pipe to the file, also with SPLICE_F_MOVE.
> > > >> >> >>
> > > >> >> >> the strace shows that the splice takes a lot of time. also when
> > > >> >> >> profiling the kernel, I found that the memcpy() called to often !!
> > > >> >> >
> > > >> >> >(didn't see this until now, axboe@suse.de doesn't work anymore)
> > > >> >> >
> > > >> >> >I'm assuming that you mean you vmsplice with SPLICE_F_GIFT, to hand
> > > >> >> >ownership of the pages to the kernel (in which case SPLICE_F_MOVE
> > > >will
> > > >> >> >work, otherwise you get a copy)? If not, that'll surely cost you a
> > > >data
> > > >> >> >copy
> > > >> >>   I'll try the vmplice with SPLICE_F_GIFT and splice with MOVE. btw,
> > > >> >> I noticed that the  splice system call takes the bulk of the time,
> > > >> >> does it mean anything?
> > > >> >
> > > >> >Hard to say without seeing some numbers :-)
> > > >> I'm out of the office, I'll send it later. btw, my test bed ( the
> > > >> receiver side ) is arm9. does it matter?
> > > >
> > > >The vmsplice is basically vm intensive, so it could matter.
> > > >
> > > >> >> >This sounds remarkably like a recent thread on lkml, you may want to
> > > >> >> >read up on that. Basically using splice for network receive is a bit
> > > >of
> > > >> >> >a work-around now, since you do need the one copy and then vmsplice
> > > >that
> > > >> >> >into a pipe. To realize the full potential of splice, we first need
> > > >> >> >socket receive support so you can skip that step (splice from socket
> > > >to
> > > >> >> >pipe, splice pipe to file).
> > > >> >> Ashwini Kulkarni posted patches that implements that, see
> > > >> >> http://lkml.org/lkml/2006/9/20/272 .  is that right?
> > > >> >> >
> > > >> >> >There was no test code attached, btw.
> > > >> >> sorry, here it is.
> > > >> >> can you please add sample application to your test tools (splice,fio
> > > >> >> ,,) that demonstrates my flow; socket to file using read & vmsplice?
> > > >> >
> > > >> >I didn't add such an example, since I had hoped that we would have
> > > >> >splice from socket support sooner rather than later. But I can do so, of
> > > >> >course.
> > > >> do you any preliminary patches? I can start playing with it.
> > > >
> > > >I don't, Intel posted a set of patches a few months ago though. I didn't
> > > >have time to look that at the time being, but you should be able to find
> > > >them in the archives.
> > > >
> > > >> >I'll try your test. One thing that sticks out initially is that you
> > > >> >should be using full pages, the splice pipe will not merge page
> > > >> >segments. So don't use a buflen less than the page size.
> > > >>
> > > >> yes, actually I  run the ttcp with -l65536 ( 64KB ), and the buffer is
> > > >> always page aligned.also, the splice/vmsplice with MOVE or GIFT will
> > > >> fail if the buffer is not a whole pages. am I rigth?
> > > >
> > > >Yes.
> > > >
> > > >I added a simple splice-fromnet example in the splice git repo, see if
> > > >you can repeat your results with that. Doing:
> > > >
> > > ># ./splice-fromnet -g 2001 | ./splice-out -m /dev/null
> > > >
> > > >and
> > > >
> > > ># cat /dev/zero | netcat localhost 2001
> > > >
> > > >gets me about 490MiB/sec, using a recv/write loop is around 413MiB/sec.
> > > >Not migrating pages gets me around 422MiB/sec.
> > > >
> > > >--
> > > >Jens Axboe
> > > >
> > > >
> > > I've done some investigation in the splice flow and found the following:
> > > even when using vmsplice with GIFT and splice with MOVE, the user
> > > buffers still copied, I see that the memcpy from pipe_to_file() is
> > > called.
> > > I added debug messages in this function and here what I got:
> > > 1. the  generic_pipe_buf_steal always fails, this is because the
> > > page_count is 2.
> > > 2. after then, the find_lock_page fails as well.
> > > 3. page_cache_alloc_cold succeeds.
> > > 4. but, since the buf->page is differs from the page (returned by
> > > page_cache_alloc_cold) the memcpy function is called.
> > >
> > > this behavior true for all the buffers that vmspliced to ext3 file.
> > > is this the expected behavior? is there any way to make the steal
> > > operation return with success?
> >
> > It works for me, with most pages. Using the vmsplice/splice-out from the
> > splice tools, doing
> >
> > $ ./vmsplice -g |  ./splice-out -m g
> >
> > about half of the pages have count==1 and the steal suceeds.
> >
> > find_lock_page() will only suceed, if the file exists and is cached
> > already. splice-out will truncate the file, so it should never suceed
> > for that case. For both the find_lock_page() success and failure case
> > (page being allocated), it's a given that we need to copy the data.
>
> Testing a simpler case (not switching buffers), all but one page was
> stolen. I tested with on-stack and posix_memalign returned buffers.
>
> --
> Jens Axboe
>
>

your test (./vmsplice -g |  ./splice-out -m) works for me. but I'm
trying to do the vmsplice and the splice in the same process. so I
modified the vmsplice test (attached)  to do the splice to file. in
this case no pages are stolen.
IMHO, when doing it in two process as your example, then the count of
some of the pages decreased when the first process exits, this why
those pages can be stolen.

saeed

------=_Part_8041_24038954.1167928024519
Content-Type: text/plain; name=vmsplice_test.c; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ewje3uey
Content-Disposition: attachment; filename="vmsplice_test.c"

LyoKICogVXNlIHZtc3BsaWNlIHRvIGZpbGwgc29tZSB1c2VyIG1lbW9yeSBpbnRvIGEgcGlwZS4g
dm1zcGxpY2Ugd3JpdGVzCiAqIHRvIHN0ZG91dCwgc28gdGhhdCBtdXN0IGJlIGEgcGlwZS4KICov
CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDx1bmlzdGQu
aD4KI2luY2x1ZGUgPGxpbWl0cy5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxnZXRv
cHQuaD4KI2luY2x1ZGUgPHN5cy9wb2xsLmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1
ZGUgPGZjbnRsLmg+CgojaW5jbHVkZSAic3BsaWNlLmgiCgojZGVmaW5lIEFMSUdOKGJ1ZikJKHZv
aWQgKikgKCgodW5zaWduZWQgbG9uZykgKGJ1ZikgKyBhbGlnbl9tYXNrKSAmIH5hbGlnbl9tYXNr
KQoKc3RhdGljIGludCBkb19jbGVhcjsKc3RhdGljIGludCBhbGlnbl9tYXNrID0gNjU1MzU7CnN0
YXRpYyBpbnQgZm9yY2VfdW5hbGlnbjsKc3RhdGljIGludCBzcGxpY2VfZmxhZ3M7CnVuc2lnbmVk
IGludCBjb3VudCA9IDE7CgppbnQgZG9fdm1zcGxpY2UoaW50ICpwZmQsIGludCBmZCwgdm9pZCAq
YjEsIHZvaWQgKmIyLCBpbnQgbGVuKQp7Ci8vCXN0cnVjdCBwb2xsZmQgcGZkID0geyAuZmQgPSBm
ZCwgLmV2ZW50cyA9IFBPTExPVVQsIH07CglzdHJ1Y3QgaW92ZWMgaW92W10gPSB7CgkJewoJCQku
aW92X2Jhc2UgPSBiMSwKCQkJLmlvdl9sZW4gPSBsZW4gLyAyLAoJCX0sCgkJewoJCQkuaW92X2Jh
c2UgPSBiMiwKCQkJLmlvdl9sZW4gPSBsZW4gLyAyLAoJCX0sCgl9OwoJaW50IHdyaXR0ZW4sIGlk
eCA9IDAsIHNwbGljZWQgPSAwOwoKCXdoaWxlIChsZW4pIHsKCQkvKgoJCSAqIGluIGEgcmVhbCBh
cHAgeW91J2QgYmUgbW9yZSBjbGV2ZXIgd2l0aCBwb2xsIG9mIGNvdXJzZSwKCQkgKiBoZXJlIHdl
IGFyZSBiYXNpY2FsbHkganVzdCBibG9ja2luZyBvbiBvdXRwdXQgcm9vbSBhbmQKCQkgKiBub3Qg
dXNpbmcgdGhlIGZyZWUgdGltZSBmb3IgYW55dGhpbmcgaW50ZXJlc3RpbmcuCgkJICovCgkJLy8J
aWYgKHBvbGwoJnBmZCwgMSwgLTEpIDwgMCkKCQkvL3JldHVybiBlcnJvcigicG9sbCIpOwoKCQl3
cml0dGVuID0gdm1zcGxpY2UocGZkWzFdLCAmaW92W2lkeF0sIDIgLSBpZHgsIHNwbGljZV9mbGFn
cyk7CgoJCWlmICh3cml0dGVuIDw9IDApCgkJCXJldHVybiBlcnJvcigidm1zcGxpY2UiKTsKCgkJ
c3BsaWNlZCA9IDA7CgkJd2hpbGUoc3BsaWNlZCA8IHdyaXR0ZW4pCgkJewoJCQlpbnQgcmV0OwoJ
CQlyZXQgPSBzcGxpY2UocGZkWzBdLCBOVUxMLCBmZCwgTlVMTCwgd3JpdHRlbiwgU1BMSUNFX0Zf
TU9WRSk7CgkJCXNwbGljZWQgKz0gcmV0OwoJCX0KCQlsZW4gLT0gd3JpdHRlbjsKCQlpZiAoKHNp
emVfdCkgd3JpdHRlbiA+PSBpb3ZbaWR4XS5pb3ZfbGVuKSB7CgkJCWludCBleHRyYSA9IHdyaXR0
ZW4gLSBpb3ZbaWR4XS5pb3ZfbGVuOwoKCQkJaWR4Kys7CgkJCWlvdltpZHhdLmlvdl9sZW4gLT0g
ZXh0cmE7CgkJCWlvdltpZHhdLmlvdl9iYXNlICs9IGV4dHJhOwoJCX0gZWxzZSB7CgkJCWlvdltp
ZHhdLmlvdl9sZW4gLT0gd3JpdHRlbjsKCQkJaW92W2lkeF0uaW92X2Jhc2UgKz0gd3JpdHRlbjsK
CQl9Cgl9CgoJcmV0dXJuIDA7Cn0KCnN0YXRpYyBpbnQgdXNhZ2UoY2hhciAqbmFtZSkKewoJZnBy
aW50ZihzdGRlcnIsICIlczogWy1jKGxlYXIpXSBbLXUobmFsaWduKV0gWy1nKGlmdCldfCAuLi5c
biIsIG5hbWUpOwoJcmV0dXJuIDE7Cn0KCnN0YXRpYyBpbnQgcGFyc2Vfb3B0aW9ucyhpbnQgYXJn
YywgY2hhciAqYXJndltdKQp7CglpbnQgYywgaW5kZXggPSAxOwoKCXdoaWxlICgoYyA9IGdldG9w
dChhcmdjLCBhcmd2LCAibjpjdWciKSkgIT0gLTEpIHsKCQlzd2l0Y2ggKGMpIHsKCQljYXNlICdj
JzoKCQkJZG9fY2xlYXIgPSAxOwoJCQlpbmRleCsrOwoJCQlicmVhazsKCQljYXNlICd1JzoKCQkJ
Zm9yY2VfdW5hbGlnbiA9IDE7CgkJCWluZGV4Kys7CgkJCWJyZWFrOwoJCWNhc2UgJ2cnOgoJCQlz
cGxpY2VfZmxhZ3MgPSBTUExJQ0VfRl9HSUZUOwoJCQlpbmRleCsrOwoJCQlicmVhazsKCQljYXNl
ICduJzoKCQkJY291bnQgPSBhdG9pKG9wdGFyZyk7CgkJCWluZGV4Kys7CgkJCWJyZWFrOwoJCWRl
ZmF1bHQ6CgkJCXJldHVybiAtMTsKCQl9Cgl9CgoJcmV0dXJuIGluZGV4Owp9CgppbnQgbWFpbihp
bnQgYXJnYywgY2hhciAqYXJndltdKQp7Cgl1bnNpZ25lZCBjaGFyICpiMSwgKmIyOwoJaW50IGZk
LCBpbmRleDsKCWludCBwZmRbMl07CgoKCWluZGV4ID0gcGFyc2Vfb3B0aW9ucyhhcmdjLCBhcmd2
KTsKCWlmIChpbmRleCA8IDAgfHwgaW5kZXggKyAxID4gYXJnYykKCQlyZXR1cm4gdXNhZ2UoYXJn
dlswXSk7CgovLwlpZiAoY2hlY2tfb3V0cHV0X3BpcGUoKSkKLy8JcmV0dXJuIHVzYWdlKGFyZ3Zb
MF0pOwoJaWYocGlwZShwZmQpIDwgMCkKCQlyZXR1cm4gZXJyb3IoInBpcGUiKTsKCglmZCA9IG9w
ZW4oYXJndltpbmRleF0sIE9fV1JPTkxZIHwgT19DUkVBVCB8IE9fVFJVTkMsIDA2NDQpOwoKICAg
ICAgICBpZiAoZmQgPCAwKQogICAgICAgICAgICAgICAgcmV0dXJuIGVycm9yKCJvcGVuIik7CgoJ
YjEgPSBBTElHTihtYWxsb2MoU1BMSUNFX1NJWkUgKyBhbGlnbl9tYXNrKSk7CgliMiA9IEFMSUdO
KG1hbGxvYyhTUExJQ0VfU0laRSArIGFsaWduX21hc2spKTsKCglpZiAoZm9yY2VfdW5hbGlnbikg
ewoJCWIxICs9IDEwMjQ7CgkJYjIgKz0gMTAyNDsKCX0KCgltZW1zZXQoYjEsIDB4YWEsIFNQTElD
RV9TSVpFKTsKCW1lbXNldChiMiwgMHhiYiwgU1BMSUNFX1NJWkUpOwoKCWRvIHsKCQlpbnQgaGFs
ZiA9IFNQTElDRV9TSVpFIC8gMjsKCgkJLyoKCQkgKiB2bXNwbGljZSB0aGUgZmlyc3QgaGFsZiBv
ZiB0aGUgYnVmZmVyIGludG8gdGhlIHBpcGUKCQkgKi8KCQlpZiAoZG9fdm1zcGxpY2UocGZkLCBm
ZCwgYjEsIGIyLCBTUExJQ0VfU0laRSkpCgkJCWJyZWFrOwoKCQkvKgoJCSAqIGZpcnN0IGhhbGYg
aXMgbm93IGluIHBpcGUsIGJ1dCB3ZSBkb24ndCBxdWl0ZSBrbm93IHdoZW4KCQkgKiB3ZSBjYW4g
cmV1c2UgaXQuCgkJICovCgoJCS8qCgkJICogdm1zcGxpY2Ugc2Vjb25kIGhhbGYKCQkgKi8KCQlp
ZiAoZG9fdm1zcGxpY2UocGZkLCBmZCwgYjEgKyBoYWxmLCBiMiArIGhhbGYsIFNQTElDRV9TSVpF
KSkKCQkJYnJlYWs7CgoJCS8qCgkJICogV2Ugc3RpbGwgZG9uJ3Qga25vdyB3aGVuIHdlIGNhbiBy
ZXVzZSB0aGUgc2Vjb25kIGhhbGYgb2YKCQkgKiB0aGUgYnVmZmVyLCBidXQgd2UgZG8gbm93IGtu
b3cgdGhhdCBhbGwgcGFydHMgb2YgdGhlIGZpcnN0CgkJICogaGFsZiBoYXZlIGJlZW4gY29uc3Vt
ZWQgZnJvbSB0aGUgcGlwZSAtIHNvIHdlIGNhbiByZXVzZSB0aGF0LgoJCSAqLwoKCQkvKgoJCSAq
IFRlc3Qgb3B0aW9uIC0gY2xlYXIgdGhlIGZpcnN0IGhhbGYgb2YgdGhlIGJ1ZmZlciwgc2hvdWxk
CgkJICogYmUgc2FmZSBub3cKCQkgKi8KCQlpZiAoZG9fY2xlYXIpIHsKCQkJbWVtc2V0KGIxLCAw
eDAwLCBTUExJQ0VfU0laRSk7CgkJCW1lbXNldChiMiwgMHgwMCwgU1BMSUNFX1NJWkUpOwoJCX0K
CX0gd2hpbGUgKGNvdW50LS0pOwoKCXJldHVybiAwOwp9Cg==
------=_Part_8041_24038954.1167928024519--
