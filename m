Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264437AbRFIIDn>; Sat, 9 Jun 2001 04:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264389AbRFIIDd>; Sat, 9 Jun 2001 04:03:33 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:61444 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S264437AbRFIIDV>;
	Sat, 9 Jun 2001 04:03:21 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106090800.f5980i101507@saturn.cs.uml.edu>
Subject: Re: temperature standard - global config option?
To: mhw@wittsend.com (Michael H. Warfield)
Date: Sat, 9 Jun 2001 04:00:44 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        mhw@wittsend.com (Michael H. Warfield), bootc@worldnet.fr (Chris Boot),
        isch@ecce.homeip.net (mirabilos {Thorsten Glaser}),
        lk@aniela.eu.org (L. K.),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <20010608191600.A12143@alcove.wittsend.com> from "Michael H. Warfield" at Jun 08, 2001 07:16:00 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael H. Warfiel writes:
> On Fri, Jun 08, 2001 at 05:16:39PM -0400, Albert D. Cahalan wrote:

>> The bits are free; the API is hard to change.
>> Sensors might get better, at least on high-end systems.
>> Rounding gives a constant 0.15 degree error.
>> Only the truly stupid would assume accuracy from decimal places.
>> Again, the bits are free; the API is hard to change.
...
> 	No...  The average person, NO, the vast majority of people,
> DO assume accuracy from decimal places and honestly do not know the
> difference between precision and accuracy.  I've had comments on this
> thread in private E-Mail the reinforce this impression.

I hope you don't think people would assume that a "float" always
has useful data in all 23 fraction bits. It is a similar case.

So here you go, a kernel-safe conversion from C to K. It works
from 0 to 238 degrees C. Print as hex, so user code can toss it
into a union or maybe abuse scanf. Adjust as needed for F to K
or for hardware with greater resolution.

/* unsigned int degrees C --> float degrees K */
unsigned ic_to_fk(unsigned c){
  unsigned exponent;
  unsigned tmp;

  tmp = (c<<23) + 0x88933333; /* Kelvin shifted 23 left */
  exponent = 127; /* IEEE floating-point bias */
  while(tmp&0xff000000){
    tmp >>= 1;
    exponent++;
  }
  tmp &= 0x007fffff; /* keep only the fraction */
  tmp |= exponent<<23;
  return tmp;
}
