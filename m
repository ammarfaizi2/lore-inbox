Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267201AbTGLAqm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 20:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267204AbTGLAqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 20:46:42 -0400
Received: from SMTP7.andrew.cmu.edu ([128.2.10.87]:12484 "EHLO
	smtp7.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S267201AbTGLAqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 20:46:40 -0400
Date: Fri, 11 Jul 2003 21:01:23 -0400 (EDT)
From: "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: [BUG][PATCH] x86 cpu identify bug?
Message-ID: <Pine.LNX.4.55L-032.0307112050190.32591@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="41988365-442255166-1057971683=:32591"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--41988365-442255166-1057971683=:32591
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello all.

I have a Transmeta TM5800 in my laptop which some time ago stopped being
able to do cpufreq stuff (/sys/devices/system/cpu/ stopped having the
relevant files in it).  I recently got time to look into the issue and
believe I have found the relevant issue:

in arch/i386/kernel/cpu/common.c, identify_cpu contains:

        if (this_cpu->c_identify)
                this_cpu->c_identify(c);
        else
                generic_identify(c);

At this point in the code, at least as far as I am able to tell, this_cpu
is always default_cpu, which lacks an ->c_identify memeber, and as such,
generic_identify is always called.  That is correct behavior, I think...
but a side effect of generic_identify is to set this_cpu.  So I believe
the correct fix is to make the flow of execution look like this:

	generic_identify(c);

	if (this_cpu->c_identify)
		this_cpu->c_identify(c);

The attached patch does that and adds some printk's that I seem to recall
were in the kernel some time ago but are no longer.

Anyway, while this may not be the correct fix, it does fix my longrun
issues, so I believe it to be correct, at least on uniprocessor systems.
This bug probably has not bitten anybody except those people with CPUs
that have CPUID bits beyond the first 64.

Keep up the good work!
--nwf;
--41988365-442255166-1057971683=:32591
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=nwf-fix_x86_identify
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.55L-032.0307112101230.32591@unix47.andrew.cmu.edu>
Content-Description: 
Content-Disposition: attachment; filename=nwf-fix_x86_identify

LS0tIGxpbnV4LTIuNS43NC1tbTEvYXJjaC9pMzg2L2tlcm5lbC9jcHUvY29t
bW9uLmMub3JpZyAyMDAzLTA3LTA2IDE3OjU3OjU5LjAwMDAwMDAwMCAtMDQw
MA0KKysrIGxpbnV4LTIuNS43NC1tbTEvYXJjaC9pMzg2L2tlcm5lbC9jcHUv
Y29tbW9uLmMgICAgICAyMDAzLTA3LTA2IDE4OjA2OjI0LjAwMDAwMDAwMCAt
MDQwMA0KQEAgLTI4OCwxMCArMjg4LDIzIEBADQogICAgICAgICAgICAgICAg
ICAgICAgICBjLT54ODYgPSAzOw0KICAgICAgICB9DQogDQotICAgICAgIGlm
ICh0aGlzX2NwdS0+Y19pZGVudGlmeSkNCisgICAgICAgZ2VuZXJpY19pZGVu
dGlmeShjKTsNCisNCisgICAgICAgcHJpbnRrKEtFUk5fREVCVUcgIkNQVTog
ICAgIEFmdGVyIGdlbmVyaWMgaWRlbnRpZnksIGNhcHM6ICUwOGx4ICUwOGx4
ICUwOGx4ICUwOGx4XG4iLA0KKyAgICAgICAgICAgICAgYy0+eDg2X2NhcGFi
aWxpdHlbMF0sDQorICAgICAgICAgICAgICBjLT54ODZfY2FwYWJpbGl0eVsx
XSwNCisgICAgICAgICAgICAgIGMtPng4Nl9jYXBhYmlsaXR5WzJdLA0KKyAg
ICAgICAgICAgICAgYy0+eDg2X2NhcGFiaWxpdHlbM10pOw0KKw0KKyAgICAg
ICBpZiAodGhpc19jcHUtPmNfaWRlbnRpZnkpIHsNCiAgICAgICAgICAgICAg
ICB0aGlzX2NwdS0+Y19pZGVudGlmeShjKTsNCi0gICAgICAgZWxzZQ0KLSAg
ICAgICAgICAgICAgIGdlbmVyaWNfaWRlbnRpZnkoYyk7DQorDQorICAgICAg
ICAgICAgICAgcHJpbnRrKEtFUk5fREVCVUcgIkNQVTogICAgIEFmdGVyIHZl
bmRvciBpZGVudGlmeSwgY2FwczogJTA4bHggJTA4bHggJTA4bHggJTA4bHhc
biIsDQorICAgICAgICAgICAgICAgICAgICAgICBjLT54ODZfY2FwYWJpbGl0
eVswXSwNCisgICAgICAgICAgICAgICAgICAgICAgIGMtPng4Nl9jYXBhYmls
aXR5WzFdLA0KKyAgICAgICAgICAgICAgICAgICAgICAgYy0+eDg2X2NhcGFi
aWxpdHlbMl0sDQorICAgICAgICAgICAgICAgICAgICAgICBjLT54ODZfY2Fw
YWJpbGl0eVszXSk7DQorICAgICAgIH0NCiANCiAgICAgICAgLyoNCiAgICAg
ICAgICogVmVuZG9yLXNwZWNpZmljIGluaXRpYWxpemF0aW9uLiAgSW4gdGhp
cyBzZWN0aW9uIHdlDQpAQCAtMzQxLDcgKzM1NCw3IEBADQogDQogICAgICAg
IC8qIE5vdyB0aGUgZmVhdHVyZSBmbGFncyBiZXR0ZXIgcmVmbGVjdCBhY3R1
YWwgQ1BVIGZlYXR1cmVzISAqLw0KIA0KLSAgICAgICBwcmludGsoS0VSTl9E
RUJVRyAiQ1BVOiAgICAgQWZ0ZXIgZ2VuZXJpYywgY2FwczogJTA4bHggJTA4
bHggJTA4bHggJTA4bHhcbiIsDQorICAgICAgIHByaW50ayhLRVJOX0RFQlVH
ICJDUFU6ICAgICBBZnRlciBhbGwgaW5pdHMsIGNhcHM6ICUwOGx4ICUwOGx4
ICUwOGx4ICUwOGx4XG4iLA0KICAgICAgICAgICAgICAgYy0+eDg2X2NhcGFi
aWxpdHlbMF0sDQogICAgICAgICAgICAgICBjLT54ODZfY2FwYWJpbGl0eVsx
XSwNCiAgICAgICAgICAgICAgIGMtPng4Nl9jYXBhYmlsaXR5WzJdLA0KDQo=

--41988365-442255166-1057971683=:32591--
