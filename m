Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267000AbRHAOBP>; Wed, 1 Aug 2001 10:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267040AbRHAOBG>; Wed, 1 Aug 2001 10:01:06 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:45060 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S267000AbRHAOA5>;
	Wed, 1 Aug 2001 10:00:57 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Tigran Aivazian <tigran@veritas.com>
Date: Wed, 1 Aug 2001 16:00:07 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: booting SMP P6 kernel on P4 hangs.
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <A4CAD66334E@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  1 Aug 01 at 10:47, Tigran Aivazian wrote:
> On Wed, 1 Aug 2001, Arjan van de Ven wrote:
> > Now all Linux installers that decide to install a SMP kernel if they
> > encounter
> > a MPTABLE already have a "except if it's a P4" exception nowadays..
> 
> that assumes that the installer itself has to be a UP kernel, which means
> the installation cannot itself serve as a "demo" of the final product in
> the fullest possible capacity... Not good, can't we workaround that
> somehow during parsing of the mp table?

MPTABLE is not what kills us. What kills us is stupid code
in setup_APIC_clocks(), which calls setup_APIC_timer even if 
calibrate_APIC_clock() finds that '...host bus clock speed is 0.0000 MHz'
But setup_APIC_timer does not handle this condition at all
and ends in endless loop waiting for internal APIC timer to decrement.
But for some unknown reason (either Intel braindamage or motherboard
vendor braindamage) most of (all?) P4 have just non-counting timer
in its APIC.

As I do not have P4 here, I do not know whether correct solution
is to disable APIC on P4 at all because of it does not work, or
whether only timer portion of APIC is broken on P4.

UNTESTED change could look like (btw it also fixes APIC aware Linux
kernel not booting in VMware on machine which has APIC):

void __int setup_APIC_clocks (void) {
      __cli();
      calibration_result = calibrate_APIC_clock();
      /*
       * Now set up the timer for real.
       */
      if (calibration_result) {
         using_apic_timer = 1;
         setup_APIC_timer((void*)calibration_result);
         __sti();
         printk("Using local APIC timer interrupts.\n");
         smp_call_function(setup_APIC_timer, (void*)calibration_result, 1, 1);
      } else {
         __sti();
         printk("Local APIC timer unusable.\n");
      }
}

                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
