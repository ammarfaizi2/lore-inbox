Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266513AbUHQRLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266513AbUHQRLe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 13:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268342AbUHQRLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 13:11:32 -0400
Received: from pop.gmx.net ([213.165.64.20]:63205 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266513AbUHQRLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 13:11:25 -0400
X-Authenticated: #1725425
Date: Tue, 17 Aug 2004 19:27:48 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Andreas Messer <andreas.messer@gmx.de>
Cc: linux-kernel@vger.kernel.org, fsteiner-mail@bio.ifi.lmu.de,
       christer@weinigel.se, alan@lxorguk.ukuu.org.uk
Subject: [RFC] list of SCSI commands
Message-Id: <20040817192748.120a87fc.Ballarin.Marc@gmx.de>
In-Reply-To: <20040817155927.GA19546@proton-satura-home>
References: <411FD919.9030702@comcast.net>
	<20040816231211.76360eaa.Ballarin.Marc@gmx.de>
	<4121A689.8030708@bio.ifi.lmu.de>
	<200408171311.06222.satura@proton>
	<20040817155927.GA19546@proton-satura-home>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I think the filtering mechanism needs to be refined before we can do
useful patches. I think it will be necessary to base filtering on
scsi_type from struct sg_scsi_id (in sg.h and scsi.h). Otherwise it will
be impossible to get functionality and safety for all devices.

I have compiled a long list of various SCSI commands and tried to
categorize them. This list is focused on mmc devices (CD-RW, DVD+R).
Many commands that are only relevant for discs are not included.

=UNCLEAR=
MODE SELECT should be safe for mmc devices (sometimes even required).
However, it often is *not* safe for other devices. This is a case,
were filtering needs to honor device types.
0x15	MODE_SELECT
0x55	MODE_SELECT_10
0x01	REZERO_UNIT

Here is a conflict between different device types. MOVE_MEDIUM for
changers; PLAY_AUDIO_12 for mmc. Are both cases safe for read?
0xA5	MOVE_MEDIUM

If I understand correctly, those commands can be used to initate
transfers between two devices. If so, read/write access to a single
device could be used to read/write all devices on the same bus.
0x18	COPY
0x39	COMPARE

I haven't found further information on the following commands. Some are
probably vendor specific. Annotations are from cdrecord.
-> 0x0D	/* qic02 Sysgen SC4000 */
-> 0x59	/* Read master cue */
-> 0xB3	GPMCD_SET_LIMITS_12
-> 0xC1
-> 0xC2	SC_SET_SUBCODE
-> 0xC3
-> 0xC4	SC_READ_PMA
-> 0xC5
-> 0xC6
-> 0xC7	SC_READ_DISK_INFO
-> 0xCE
-> 0xCF
-> 0xD4		/* Read audio command */
-> 0xD8		/* read audio command */
-> 0xDF
-> 0xE0	SC_BUFFER_INQUIRY
-> 0xE1	SC_WRITE_PMA
-> 0xE2
-> 0xE3	SC_FREEZE
-> 0xE4	SC_CLEAR_SUBCODE
-> 0xE5
-> 0xE6	SC_NEXT_WR_ADDRESS
-> 0xE7
-> 0xE9
-> 0xEB
-> 0xEC	SC_OPC_EXECUTE
-> 0xED
-> 0xEE	/* Read session info */
-> 0xEF	SC_READ_PEAK_BUF_CAP
-> 0xF0
-> 0xF1
-> 0xF2
-> 0xF3
-> 0xF5
-> 0xF6
-> 0xF8

=READ=
0x00	TEST_UNIT_READY
0x03	REQUEST_SENSE
0x08	READ_6
0x0B	SEEK_6
0x12	INQUIRY
0x1A	MODE_SENSE
0x23	GPCMD_READ_FORMAT_CAPACITIES
0x25	GPCMD_READ_CDVD_CAPACITY
0x28	READ_10
0x2B	SEEK_10
0x2F	GPCMD_VERIFY_10
0x3C	READ_BUFFER
0x42	GPCMD_READ_SUBCHANNEL
0x43	GPCMD_READ_TOC_PMA_ATIP
0x44	GPCMD_READ_HEADER	//not found in spec, _sounds_ safe
0x45	GPCMD_PLAY_AUDIO_10
0x46	GPCMD_GET_CONFIGURATION
0x47	GPCMD_PLAY_AUDIO_MSF
0x4A	GPCMD_GET_EVENT_STATUS_NOTIFICATION
0x4B	GPCMD_PAUSE_RESUME
0x4E	GPCMD_STOP_PLAY_SCAN
0x51	GPCMD_READ_DISC_INFO
0x52	GPCMD_READ_TRACK_RZONE_INFO
0x5A	MODE_SENSE_10
-> 0x5C	GPCMD_READ_BUFFER_CAPACITY
0x88	READ_16
0xA3	GPCMD_SEND_KEY
0xA4	GPCMD_REPORT_KEY
0xA6	GPCMD_LOAD_UNLOAD
0xA7	GPCMD_SET_READ_AHEAD
0xA8	READ_12
0xAC	GPCMD_GET_PERFORMANCE
0xAD	GPCMD_READ_DVD_STRUCTURE
0xB6	GPCMD_SET_STREAMING
0xB9	GPCMD_READ_CD_MSF
0xBA	GPCMD_SCAN
0xBB	GPCMD_SET_SPEED
0xBD	GPCMD_MECHANISM_STATUS
0xBE	GPCMD_READ_CD

=WRITE=
0x04	FORMAT_UNIT	// is this safe for disks?
0x0A	WRITE_6
0x2A	WRITE_10
0x2E	GPCMD_WRITE_AND_VERIFY_10
0x35	GPCMD_FLUSH_CACHE
0xAA	WRITE_12
0x8a	WRITE_16
0xA1	GPCMD_BLANK
0x53	GPCMD_RESERVE_RZONE_TRACK
0x54	GPCMD_SEND_OPC
0x58	GPCMD_REPAIR_RZONE_TRACK
0x5B	GPCMD_CLOSE_TRACK
0x1E	GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL
-> 0x5D	GPCMD_SEND_CUE
-> 0x2C	GPCMD_ERASE
-> 0xBF	GPCMD_SEND_DVD_STRUCTURE	

=RAWIO=
Some modes of WRITE_BUFFER are safe even for read, others
overwrite firmware. Misdesign.
0x3B	WRITE_BUFFER

0x07	REASSIGN_BLOCKS
0x16	RESERVE
0x17	RELEASE
