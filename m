Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbTJNSPe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbTJNSPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:15:34 -0400
Received: from nondot.cs.uiuc.edu ([128.174.245.159]:44729 "EHLO nondot.org")
	by vger.kernel.org with ESMTP id S262691AbTJNSPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:15:24 -0400
Date: Tue, 14 Oct 2003 13:31:31 -0500 (CDT)
From: Chris Lattner <sabre@nondot.org>
To: linux-kernel@vger.kernel.org
Subject: [x86] Access off the bottom of stack causes a segfault?
Message-ID: <Pine.LNX.4.44.0310141320020.3869-100000@nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My compiler is generating accesses off the bottom of the stack (address
below %esp).  Is there some funny kernel interaction that I should be
aware of with this?  I'm periodically getting segfaults.

Example:

int main() {
   int test[4000];
...
   return 0;
}

Generated code:
        .intel_syntax
...
main:
        mov DWORD PTR [%ESP - 16004], %EBP    # Save EBP to stack
        mov %EBP, %ESP                        # Set up EBP
        sub %ESP, 16004                       # Finally adjust ESP
        lea %EAX, DWORD PTR [%EBP - 16000]    # Get the address of the array
...
        mov %EAX, 0                           # Setup return value
        mov %ESP, %EBP                        # restore ESP
        mov %EBP, DWORD PTR [%ESP - 16004]    # Restore EBP from stack
        ret

This seems like perfectly valid X86 code (though unconventional), but it
is causing segfaults pretty consistently (on the first instruction).
Does the linux kernel assume that page faults will be above the stack
pointer if the stack needs to be expanded?

Thanks,

-Chris

-- 
http://llvm.cs.uiuc.edu/
http://www.nondot.org/~sabre/Projects/


