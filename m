Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131058AbRAOWHr>; Mon, 15 Jan 2001 17:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131363AbRAOWHh>; Mon, 15 Jan 2001 17:07:37 -0500
Received: from mailg.telia.com ([194.22.194.26]:5383 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S131058AbRAOWHZ>;
	Mon, 15 Jan 2001 17:07:25 -0500
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_C758GGJYQOG356JFOZI4"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: george anzinger <george@mvista.com>, nigel@nrg.org
Subject: Re: Latency: allowing resheduling while holding spin_locks
Date: Mon, 15 Jan 2001 23:02:00 +0100
X-Mailer: KMail [version 1.2]
Cc: Roger Larsson <roger.larsson@norran.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.05.10101131335380.10740-100000@cosmic.nrg.org> <3A60ED83.1B70410A@mvista.com>
In-Reply-To: <3A60ED83.1B70410A@mvista.com>
MIME-Version: 1.0
Message-Id: <01011523020003.01217@dox>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_C758GGJYQOG356JFOZI4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Sunday 14 January 2001 01:06, george anzinger wrote:
> Nigel Gamble wrote:
> > On Sat, 13 Jan 2001, Roger Larsson wrote:
> > > A rethinking of the rescheduling strategy...
> >
> > Actually, I think you have more-or-less described how successful
> > preemptible kernels have already been developed, given that your
> > "sleeping spin locks" are really just sleeping mutexes (or binary
> > semaphores).
> >
> > 1.  Short critical regions are protected by spin_lock_irq().  The maximum
> > value of "short" is therefore bounded by the maximum time we are happy
> > to disable (local) interrupts - ideally ~100us.
> >
> > 2.  Longer regions are protected by sleeping mutexes.
> >
> > 3.  Algorithms are rearchitected until all of the highly contended locks
> > are of type 1, and only low contention locks are of type 2.
> >
> > This approach has the advantage that we don't need to use a no-preempt
> > count, and test it on exit from every spinlock to see if a preempting
> > interrupt that has caused a need_resched has occurred, since we won't
> > see the interrupt until it's safe to do the preemptive resched.
>
> I agree that this was true in days of yore.  But these days the irq
> instructions introduce serialization points and, me thinks, may be much
> more time consuming than the "++, --, if (false)" that a preemption
> count implemtation introduces.  Could some one with a knowledge of the
> hardware comment on this?
>
> I am not suggesting that the "++, --, if (false)" is faster than an
> interrupt, but that it is faster than cli, sti.  Of course we are
> assuming that there is <stuff> between the cli and the sti as there is
> between the ++ and the -- if (false).
>

The problem with counting scheme is that you can not schedule inside any
spinlock - you have to split them up. Maybe you will have to do that anyway.
But if your RT process never needs more memory - it should be quite safe.

The difference with a sleeping mutex is that it can be made lazier - keep it
in the runlist, there should be very few...

See first patch attempt.

(George, Nigel told me about your idea before I sent the previous mail. So 
major influence comes from you. But I do not think that it is equivalent)

/RogerL

Note: changed email...
--------------Boundary-00=_C758GGJYQOG356JFOZI4
Content-Type: text/x-c;
  charset="iso-8859-1";
  name="patch-2.4.1-preX-rescheduleinspinlock"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch-2.4.1-preX-rescheduleinspinlock"

LS0tIC4vbGludXgva2VybmVsL3NjaGVkLmMub3JpZwlTYXQgSmFuIDEzIDE5OjE5OjIwIDIwMDEK
KysrIC4vbGludXgva2VybmVsL3NjaGVkLmMJU2F0IEphbiAxMyAyMzoyNzoxMyAyMDAxCkBAIC0x
NDQsNyArMTQ0LDcgQEAKIAkgKiBBbHNvLCBkb250IHRyaWdnZXIgYSBjb3VudGVyIHJlY2FsY3Vs
YXRpb24uCiAJICovCiAJd2VpZ2h0ID0gLTE7Ci0JaWYgKHAtPnBvbGljeSAmIFNDSEVEX1lJRUxE
KQorCWlmIChwLT5wb2xpY3kgJiAoU0NIRURfWUlFTEQgfCBTQ0hFRF9TUElOTE9DSykpCiAJCWdv
dG8gb3V0OwogCiAJLyoKQEAgLTk3OCw3ICs5NzgsNyBAQAogCXJlYWRfbG9jaygmdGFza2xpc3Rf
bG9jayk7CiAJcCA9IGZpbmRfcHJvY2Vzc19ieV9waWQocGlkKTsKIAlpZiAocCkKLQkJcmV0dmFs
ID0gcC0+cG9saWN5ICYgflNDSEVEX1lJRUxEOworCQlyZXR2YWwgPSBwLT5wb2xpY3kgJiB+KFND
SEVEX1lJRUxEIHwgU0NIRURfU1BJTkxPQ0spOwogCXJlYWRfdW5sb2NrKCZ0YXNrbGlzdF9sb2Nr
KTsKIAogb3V0X25vdW5sb2NrOgpAQCAtMTI2NywzICsxMjY3LDU0IEBACiAJYXRvbWljX2luYygm
aW5pdF9tbS5tbV9jb3VudCk7CiAJZW50ZXJfbGF6eV90bGIoJmluaXRfbW0sIGN1cnJlbnQsIGNw
dSk7CiB9CisKK3ZvaWQgd2FrZXVwX3NwaW5sb2NrX3lpZWxkZXIoc3BpbmxvY2tfdCAqbG9jaykK
K3sKKwlpbnQgbmVlZF9yZXNjaGVkID0gMDsKKwlzdHJ1Y3QgbGlzdF9oZWFkICp0bXA7CisJc3Ry
dWN0IHRhc2tfc3RydWN0ICpwOworCQorCS8qIEkgZG8gbm90IGxpa2UgdGhpcyBwYXJ0Li4uCisJ
KiAgIG5vdCBTTVAgc2FmZSwgdGhlIHJ1bnF1ZXVlIG1pZ2h0IGNoYW5nZSB1bmRlciB1cy4uLgor
CSogICBjYW4gbm90IHVzZSBzcGlubG9ja3MuLi4KKwkqICAgcnVubGlzdCBtaWdodCBiZSBsb25n
Li4uCisJKi8KKwlsb2NhbF9pcnFzYXZlKCZmbGFncyk7CisJaWYgKGxvY2stPnNwaW4pIHsKKwkJ
Lyogc29tZW9uZSBpcyAic3Bpbm5pbmciIG9uIGl0CisJCSAqIGl0IGhhcyB0byBoYXZlIGhpZ2hl
ciBwcmlvIHRoYW4gdGhpcworCQkgKiBsZXQgZ28gb2YgQUxMIDotKCBzcGlubmluZyBwcm9jZXNz
ZXMKKwkJICovCisJCWxvY2stPnNwaW4gPSAwOworCisJCWxpc3RfZm9yX2VhY2godG1wLCAmcnVu
cXVldWVfaGVhZCkgeworCQkJcCA9IGxpc3RfZW50cnkodG1wLCBzdHJ1Y3QgdGFza19zdHJ1Y3Qs
IHJ1bl9saXN0KTsKKwkJCWlmIChwLT5wb2xpY3kgJiBTQ0hFRF9TUElOTE9DSykgeworCQkJCXAt
PnBvbGljeSAmPSB+U0NIRURfU1BJTkxPQ0s7CisJCQl9CisJCX0KKworCQluZWVkX3Jlc2NoZWQg
PSAxOworCX0KKwlsb2NhbF9pcnFyZXN0b3JlKCZmbGFncyk7CisKKwkvKiBhbGwgaGlnaGVyIHBy
aW8gd2lsbCBnZXQgYSBjaGFuY2UgdG8gcnVuLi4uICovCisJaWYgKG5lZWRfcmVzY2hlZCkKKwkJ
c2NoZWR1bGVfcnVubmluZygpOworfQorCit2b2lkIHNjaGVkdWxlX3NwaW5sb2NrKHNwaW5sb2Nr
X3QgKmxvY2spCit7CisJd2hpbGUgKHRlc3RfYW5kX3NldChsb2NrLT5sb2NrKSkgeworCQkvKiBu
b3RlOiBvd25lciBjYW4gbm90IHJhY2UgaGVyZSwgaXQgaGFzIGxvd2VyIHByaW8gKi8KKworCQls
b2NrLT5zcGlub24gPSAxOworCQlwLT5wb2xpY3kgfD0gU0NIRURfU1BJTkxPQ0s7CisJCXNjaGVk
dWxlX3J1bm5pbmcoKTsKKwkJLyogd2lsbCBiZSByZWxlYXNlZCBpbiBwcmlvcml0eSBvcmRlciAq
LworCX0KK30KKworCisKKwotLS0gLi9saW51eC9pbmNsdWRlL2xpbnV4L3NjaGVkLmgub3JpZwlT
YXQgSmFuIDEzIDE5OjI1OjUzIDIwMDEKKysrIC4vbGludXgvaW5jbHVkZS9saW51eC9zY2hlZC5o
CVNhdCBKYW4gMTMgMTk6MjY6MzEgMjAwMQpAQCAtMTE5LDYgKzExOSw3IEBACiAgKiB5aWVsZCB0
aGUgQ1BVIGZvciBvbmUgcmUtc2NoZWR1bGUuLgogICovCiAjZGVmaW5lIFNDSEVEX1lJRUxECQkw
eDEwCisjZGVmaW5lIFNDSEVEX1NQSU5MT0NLICAgICAgICAgIDB4MjAKIAogc3RydWN0IHNjaGVk
X3BhcmFtIHsKIAlpbnQgc2NoZWRfcHJpb3JpdHk7Ci0tLSAuL2xpbnV4L2luY2x1ZGUvbGludXgv
c3BpbmxvY2suaC5vcmlnCVNhdCBKYW4gMTMgMTk6NDA6MzAgMjAwMQorKysgLi9saW51eC9pbmNs
dWRlL2xpbnV4L3NwaW5sb2NrLmgJU2F0IEphbiAxMyAyMTo1MToxNCAyMDAxCkBAIC02NiwxNiAr
NjYsMzcgQEAKIAogdHlwZWRlZiBzdHJ1Y3QgewogCXZvbGF0aWxlIHVuc2lnbmVkIGxvbmcgbG9j
azsKKwk/Pz8gcXVldWU7CiB9IHNwaW5sb2NrX3Q7CiAjZGVmaW5lIFNQSU5fTE9DS19VTkxPQ0tF
RCAoc3BpbmxvY2tfdCkgeyAwIH0KIAordm9pZCB3YWtldXBfc3BpbmxvY2tfeWllbGRlcihzcGlu
bG9ja190ICpsb2NrKTsKK3ZvaWQgc2NoZWR1bGVfc3BpbmxvY2soc3BpbmxvY2tfdCAqbG9jayk7
CisKICNkZWZpbmUgc3Bpbl9sb2NrX2luaXQoeCkJZG8geyAoeCktPmxvY2sgPSAwOyB9IHdoaWxl
ICgwKQogI2RlZmluZSBzcGluX2lzX2xvY2tlZChsb2NrKQkodGVzdF9iaXQoMCwobG9jaykpKQot
I2RlZmluZSBzcGluX3RyeWxvY2sobG9jaykJKCF0ZXN0X2FuZF9zZXRfYml0KDAsKGxvY2spKSkK
KyNkZWZpbmUgc3Bpbl90cnlsb2NrKGxvY2spCSghdGVzdF9hbmRfc2V0X2JpdCgwLChsb2NrKSkp
IC8qIGZhaWwgaGFuZGxlZCAqLworCisjZGVmaW5lIHNwaW5fbG9jayh4KQkJZG8geyAKKyAgICAg
ICAgaWYgKHRlc3RfYW5kX3NldChsb2NrLT5sb2NrKSkgXAorCSAgICAgICBzY2hlZHVsZV9zcGlu
bG9jaygpOyAvKiBraW5kIG9mIHlpZWxkLCBnaXZpbmcgbG93IGdvb2RuZXNzLCBzdGlja3kgKi8g
XAorICAgICAgICB9IHdoaWxlICgwKQorCisjZGVmaW5lIHNwaW5fdW5sb2NrX3dhaXQoeCkJZG8g
eyBcCisgICAgICAgIGlmIChzcGluX2lzX2xvY2tlZCh4KSkgIHsgXAorICAgICAgICAgICAgICAg
IHNjaGVkdWxlX3NwaW5sb2NrKCk7IFwKKyAgICAgICAgICAgICAgICBzcGluX3VubG9jaygpOyBc
CisgICAgICAgIH0gXAorICAgIH0gd2hpbGUgKDApCiAKLSNkZWZpbmUgc3Bpbl9sb2NrKHgpCQlk
byB7ICh4KS0+bG9jayA9IDE7IH0gd2hpbGUgKDApCi0jZGVmaW5lIHNwaW5fdW5sb2NrX3dhaXQo
eCkJZG8geyB9IHdoaWxlICgwKQotI2RlZmluZSBzcGluX3VubG9jayh4KQkJZG8geyAoeCktPmxv
Y2sgPSAwOyB9IHdoaWxlICgwKQorI2RlZmluZSBzcGluX3VubG9jayh4KQkJZG8geyBcCisgICAg
ICAgICAoeCktPmxvY2sgPSAwOyBcCitcCisgICAgICAgICAvKiBub3RlOiBzb21lb25lIHdpdGgg
aGlnaGVyIHByaW8gdGhhbiBtZSwgXAorICAgICAgICAgICAgbWlnaHQgc3RlYWwgdGhlIGxvY2sg
ZnJvbSBldmVuIGhpZ2hlciBwcmlvIHdhaXRlcnMgaGVyZSAqLyBcCitcCisgICAgICAgICBpZiAo
bG9jay0+cXVldWUpIFwKKyAgICAgICAgICAgICAgICAgd2FrZXVwX3NwaW5sb2NrX3lpZWxkZXIo
bG9jayk7IH0gd2hpbGUgKDApCiAKICNlbHNlIC8qIChERUJVR19TUElOTE9DS1MgPj0gMikgKi8K
IAotLS0gLi9saW51eC9kcml2ZXJzL3NvdW5kL2VtdTEwazEvaXJxbWdyLmMub3JpZwlNb24gSmFu
ICA4IDE4OjQ5OjM1IDIwMDEKKysrIC4vbGludXgvZHJpdmVycy9zb3VuZC9lbXUxMGsxL2lycW1n
ci5jCU1vbiBKYW4gIDggMTk6MDI6NDYgMjAwMQpAQCAtNDIsNiArNDIsNyBAQAogewogCXN0cnVj
dCBlbXUxMGsxX2NhcmQgKmNhcmQgPSAoc3RydWN0IGVtdTEwazFfY2FyZCAqKSBkZXZfaWQ7CiAJ
dTMyIGlycXN0YXR1cywgdG1wOworCXUzMiBsaW1pdF9sb29wOwogCiAJaWYgKCEoaXJxc3RhdHVz
ID0gZW11MTBrMV9yZWFkZm4wKGNhcmQsIElQUikpKQogCQlyZXR1cm47CkBAIC02MCw2ICs2MSw3
IEBACiAJICoqIC0gRXJpYwogCSAqLwogCisJbGltaXRfbG9vcCA9IDA7IC8qIHdyYXAgZmlyc3Qs
IHdhaXQgZm9yIG5leHQgemVybyAqLwogCWRvIHsKIAkJRFBEKDQsICJpcnEgc3RhdHVzICV4XG4i
LCBpcnFzdGF0dXMpOwogCkBAIC04NSw4ICs4NywxMiBAQAogCiAJCWVtdTEwazFfd3JpdGVmbjAo
Y2FyZCwgSVBSLCB0bXApOwogCi0JfSB3aGlsZSAoKGlycXN0YXR1cyA9IGVtdTEwazFfcmVhZGZu
MChjYXJkLCBJUFIpKSk7CisJfSB3aGlsZSAoKGlycXN0YXR1cyA9IGVtdTEwazFfcmVhZGZuMChj
YXJkLCBJUFIpKSAmJgorCQkgLS1saW1pdF9sb29wKTsKKworCWlmIChsaW1pdF9sb29wID09IDAg
JiYgaXJxc3RhdHVzICE9IDApCisJICBwcmludGsoS0VSTl9FUlIgImxvb3AgbGltaXQgcmVhY2hl
ZCBpbiBlbXUxMGssIGlycXN0YXR1cyAleFxuIiwKKwkJIGlycXN0YXR1cyk7CiAKIAlyZXR1cm47
CiB9Ci0K

--------------Boundary-00=_C758GGJYQOG356JFOZI4--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
