Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278549AbRJSRCc>; Fri, 19 Oct 2001 13:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278550AbRJSRCW>; Fri, 19 Oct 2001 13:02:22 -0400
Received: from mail010.syd.optusnet.com.au ([203.2.75.171]:6811 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S278549AbRJSRCO>; Fri, 19 Oct 2001 13:02:14 -0400
Date: Sat, 20 Oct 2001 03:01:38 +1000
To: linux-kernel@vger.kernel.org
Cc: mochel@osdl.org
Subject: Re: [RFC] New Driver Model for 2.5
Message-ID: <20011020030138.A22096@beernut.flames.org.au>
Reply-To: Pine.LNX.4.33.0110181601250.9099-100000@osdlab.pdx.osdl.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Kevin Easton <s3159795@student.anu.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am I correct in thinking that the current "state of play" after these recent
discussions is a 3 step suspend process, following an algorithm similar to:

    if (suspend_prepare(device_list) == failed) {
        suspend_cancel(device_list);
        return failed;
    }

    if (suspend_save_state(device_list) == failed) {
        suspend_cancel(device_list);
        return failed;
    }

    write_out_state();
    suspend_now(device_list);

Where these operations on the drivers are defined as:

suspend_prepare:
    Allocate any memory needed for saving of state, suspending & resuming
    device.  LAST CHANCE TO ALLOCATE MEMORY.

suspend_save_state:
    Stop accepting requests.
    Save state of device.

suspend_now:
    Turn off device.

suspend_cancel:
    Free any memory that may have been allocated for saving of state.
    Resume normal operation.

...and write_out_state() somehow stores the saved (in memory) state of the
devices to nonvolatile storage.

If this is approximately the right idea, then how will write_out_state work if
the device(s) that this operation uses aren't accepting requests anymore 
(because they've done suspend_save_state)?  Is it that "Stop accepting 
requests" is actually "Stop accepting requests that will cause a change in the
device state"?  In that case, devices that can have the state written out to 
them will be limited to those where the act of writing it out will never cause
such a request, right?

    - Kevin.

