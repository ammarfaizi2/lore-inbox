Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbSIXKtK>; Tue, 24 Sep 2002 06:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261643AbSIXKtJ>; Tue, 24 Sep 2002 06:49:09 -0400
Received: from angband.namesys.com ([212.16.7.85]:64906 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261642AbSIXKtI>; Tue, 24 Sep 2002 06:49:08 -0400
Date: Tue, 24 Sep 2002 14:54:21 +0400
From: Oleg Drokin <green@namesys.com>
To: Jakob Oestergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org,
       Hans Reiser <reiser@namesys.com>
Subject: Re: ReiserFS buglet
Message-ID: <20020924145421.A23754@namesys.com>
References: <20020924072455.GE2442@unthought.net> <20020924132110.A22362@namesys.com> <20020924092720.GF2442@unthought.net> <20020924134816.A23185@namesys.com> <20020924100338.GH2442@unthought.net> <20020924142521.C23185@namesys.com> <20020924103923.GI2442@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020924103923.GI2442@unthought.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Sep 24, 2002 at 12:39:24PM +0200, Jakob Oestergaard wrote:
> > amount of data. If it writes these sectors from the start of the data flow,
> > what will it do on data transefer timeout?
> > So I still think that data is written on disk in 512 bytes atomic blocks
> > until I see IDE device that does otherwise (and then I will probably
> > dig some IDE datasheet and find out they are violating some spec ;) )
> That would be really interesting.
> I mean, my point still stands even though my proof was wrong, unless
> someone can come up with a "proof" (a spec would be close enough) that
> writes must be 512 bytes.

Ok, here's what I have quckly found, it seems to proove that my assumptions are
right:
http://www.repairfaq.org/filipg/LINK/F_IDE-tech.html
Section: "9. Command Descriptions":
Here the quote:
   The recommended procedure for executing a command on the selected
   drive is:

    1. Wait for drive to clear BUSY.
    2. Load required parameters in the Command Block Registers.
    3. Activate the Interrupt Enable (nIEN) bit.
    4. Wait for drive to set DRDY.
    5. Write the command code to the Command Register.
   Execution of the command begins as soon as the drive loads the Command
   Block Register.

Commands:
   E8h: Write Buffer
          This command enables the host to overwrite the contents of the
          drive's sector buffer with any data pattern. On receipt of this
          comand the drive sets BUSY within 400 nsec, sets up the sector
          buffer for a write operation, sets DRQ and clears BUSY. The
          host then writes up to 512 bytes of data to the buffer. The
          Read Buffer and Write Buffer are synchronized so that back to
          back Read Buffer and Write Buffer commands access the same 512
          bytes within the buffer.
   30h: Write Sectors with Retry
   31h: Write Sectors without Retry
          This command writes from 1 to 256 sectors beginning at the
          specified sector and as stated earlier, a sector count of 0 in
          the Command Block Register will request 256 sectors. When the
          drive accepts this command it sets DRQ and wait for the host to
          fill the sector buffer with the data to be written to disk. No
          interrupt is generated to start the first buffer fill operation
          and once the buffer is full the drive clears the DRQ, sets BUSY
          and begins execution of the command.

          For single sector Write operations, the drive sets DRQ upon
          receipt of the command and waits for the host to fill the
          sector buffer. Once a sector has been transferred, the drive
          sets BUSY and clears DRQ. If the drive is not on the requested
          cylinder and head an inplied seek and/or head switch is
          performed. Once the desired track is reached the drive searches
          for the appropriate ID field.

....
End of quote

So no write should be even started until entire sector buffer is filled.

Bye,
    Oleg
