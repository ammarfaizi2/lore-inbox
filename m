Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131374AbRAJX6h>; Wed, 10 Jan 2001 18:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132017AbRAJX61>; Wed, 10 Jan 2001 18:58:27 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:36615
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129933AbRAJX6S>; Wed, 10 Jan 2001 18:58:18 -0500
Date: Wed, 10 Jan 2001 15:18:22 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Grant Grundler <grundler@cup.hp.com>
cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, taggart@fc.hp.com,
        m.ashley@unsw.edu.au
Subject: Re: [PATCH] 2.2.18pre21 ide-disk.c for OB800
In-Reply-To: <200101102313.PAA05648@milano.cup.hp.com>
Message-ID: <Pine.LNX.4.10.10101101517290.26053-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wrong method.

APMD has to have the ablity to remember the state.
Spindown is basically a power reset to the drive.

On Wed, 10 Jan 2001, Grant Grundler wrote:

> hi folks,
> I've been playing with hdparms on the OB800 (running debian 2.2 -
> that 2.2.18pre21 based) as shown on:
> 
> 	http://www.phys.unsw.edu.au/~mcba/hp800ct.html
> 
> The appended patch attemps to fix the following errors seen when the IDE
> drive spins up after a sleep mode:
> 	hda: multwrite_intr: status=0x51 { DriveReady SeekComplete Error }
> 	hda: multwrite_intr: error=0x04 { DriveStatusError }
> *or*
> 	hda: read_intr: status=0x59 { DriveReady SeekComplete DataReady Error }
> 	hda: read_intr: error=0x04 { DriveStatusError }
> 
> After several retries, both result in "ide0: reset: success" and life
> is good again. The patch avoids the reset.
> 
> I have two theories on what's wrong: drive forgets multmode was enabled
> *or* drive doesn't spin up media when poked. The web page above claims
> the drive forgets the hdparm -S (idle time before sleep) and provides a
> script to reset that. I've wondered if the same might be true for Multi-sector
> mode. Anyway, resetting MultMode seems to fix the problem.
> 
> I've learned the drive will spin down in four different cases:
> 1) hdparm -S10 (50 seconds) and let the machine idle that long
> 2) BIOS APM has been idle and decides it time to sleep (I have
>    mine set to 3 minutes right now)
> 3) "on/off" button on keyboard
> 4) hdparm -Y /dev/hda  (this case still generates similar errors.)
> 
> This patch does NOT fix another symptom:
> o "irq timeout: status=0xd0 { Busy }" followed by "ide0: reset: success".
> 
> enjoy!
> grant
> 
> grundler at puffin.external.hp.com
> parisc-linux I/O hacker
> 
> 
> --- kernel-source-2.2.18pre21-2.2.18pre21.ORIG/drivers/block/ide-disk.c	Wed Jun  7 14:26:42 2000
> +++ linux/drivers/block/ide-disk.c	Wed Jan 10 15:03:15 2001
> @@ -123,6 +123,23 @@ static int lba_capacity_is_ok (struct hd
>  }
>  
>  /*
> + * set_multmode_intr() is invoked on completion of a WIN_SETMULT cmd.
> + */
> +static ide_startstop_t set_multmode_intr (ide_drive_t *drive)
> +{
> +	byte stat = GET_STAT();
> +
> +	if (OK_STAT(stat,READY_STAT,BAD_STAT)) {
> +		drive->mult_count = drive->mult_req;
> +	} else {
> +		drive->mult_req = drive->mult_count = 0;
> +		drive->special.b.recalibrate = 1;
> +		(void) ide_dump_status(drive, "set_multmode", stat);
> +	}
> +	return ide_stopped;
> +}
> +
> +/*
>   * read_intr() is the handler for disk read/multread interrupts
>   */
>  static ide_startstop_t read_intr (ide_drive_t *drive)
> @@ -145,6 +162,32 @@ static ide_startstop_t read_intr (ide_dr
>  		return ide_started;
>  	}
>  #endif
> +	else if ((0x59 == stat) && drive->mult_count) {
> +		/*
> +		** HP OB800 laptop HD (IBM-DMCA-21440) will spin down
> +		** and *forget* multi-mode parms when it spins up on
> +		** the next access. The following fixes the stat 0x51
> +		** w/error 0x4 messages and reset after spinning up.
> +		** ggg 9.1.2001
> +		**
> +		** If first request which triggers resume is a write,
> +		**  stat == 0x51 (vs. 0x59 for read).
> +		**
> +		** 1) Check if HD forgot.
> +		** 2) If so, set them again, otherwise report error.
> +		** 3) I/O is still queued - will get retried (I hope).
> +		**
> +		** REVISIT: Don't know how to easily check HD settings.
> +		**    Not sure it's possible since it doesn't just seem to
> +		**    be a simple register read. Not checking HD settings
> +		**    risks an infinite loop/wedged system. I would expect
> +		**    to get a different error for the SETMULT cmd.
> +		*/
> +		{
> +			ide_cmd(drive, WIN_SETMULT, drive->mult_req, &set_multmode_intr);
> +			return ide_started;
> +		}
> +	}
>  	msect = drive->mult_count;
>  	
>  read_next:
> @@ -331,24 +374,17 @@ static ide_startstop_t multwrite_intr (i
>  		}
>  		return ide_stopped;     /* the original code did this here (?) */ 
>  	}
> -	return ide_error(drive, "multwrite_intr", stat);
> -}
> -
> -/*
> - * set_multmode_intr() is invoked on completion of a WIN_SETMULT cmd.
> - */
> -static ide_startstop_t set_multmode_intr (ide_drive_t *drive)
> -{
> -	byte stat = GET_STAT();
> -
> -	if (OK_STAT(stat,READY_STAT,BAD_STAT)) {
> -		drive->mult_count = drive->mult_req;
> -	} else {
> -		drive->mult_req = drive->mult_count = 0;
> -		drive->special.b.recalibrate = 1;
> -		(void) ide_dump_status(drive, "set_multmode", stat);
> +	else if (0x51 == stat) {
> +		/*
> +		** HP OB800 laptop HD (IBM-DMCA-21440) fix.
> +		** See comments in read_intr().
> +		*/
> +		{
> +			ide_cmd(drive, WIN_SETMULT, drive->mult_req, &set_multmode_intr);
> +			return ide_started;
> +		}
>  	}
> -	return ide_stopped;
> +	return ide_error(drive, "multwrite_intr", stat);
>  }
>  
>  /*
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
