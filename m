Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268970AbRHFTuC>; Mon, 6 Aug 2001 15:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268966AbRHFTtw>; Mon, 6 Aug 2001 15:49:52 -0400
Received: from 63-216-69-197.sdsl.cais.net ([63.216.69.197]:15880 "EHLO
	vyger.freesoft.org") by vger.kernel.org with ESMTP
	id <S268970AbRHFTtk>; Mon, 6 Aug 2001 15:49:40 -0400
Message-ID: <3B6EF4DA.8899E1D3@freesoft.org>
Date: Mon, 06 Aug 2001 15:49:46 -0400
From: Brent Baccala <baccala@freesoft.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Dharm <mdharm@one-eyed-alien.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
Subject: Re: Problem with usb-storage using HP 8200 external CD-ROM burner
In-Reply-To: <3B68FB0C.5BC83115@freesoft.org> <20010806014626.K24225@one-eyed-alien.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dharm wrote:
> 
> Brent --
> 
> As the module maintainer, I'm very intereted in your analysis.....
> 
> Of course, I'm interested in knowing how the command_abort function can be
> made safe -- I think there are already patches in the 2.4.8 kernel which
> should fix the cause of this function getting called.
> 
> Any ideas on how to fix this issue?

Well, what comes to mind immediately is two things.

First, does scsiglue.c's abort_command really need to handshake with the
code in usb.c?  If not, just get rid of the down and its matching up.

Second, this code (in scsi_error.c):

      774         spin_lock_irqsave(&io_request_lock, flags);
      775         rtn = SCpnt->host->hostt->eh_abort_handler(SCpnt);
      776         spin_unlock_irqrestore(&io_request_lock, flags);

seems like a real shotgun approach.  Get rid of the spinlock stuff, and
make sure that the abort handlers lock io_request_lock themselves if
they need it.  Of course, this would require changes to all the scsi
drivers.

I don't work with the kernel that much, so really I'm hoping somebody
else can suggest the fix - that's why I posted it in the first place. 
I'll cc this to the mailing lists, in the hope that somebody will have
an idea.

-- 
                                        -bwb

                                        Brent Baccala
                                        baccala@freesoft.org

==============================================================================
       For news from freesoft.org, subscribe to announce@freesoft.org:
   
mailto:announce-request@freesoft.org?subject=subscribe&body=subscribe
==============================================================================
