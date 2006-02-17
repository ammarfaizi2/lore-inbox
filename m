Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWBQV0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWBQV0I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 16:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWBQV0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 16:26:08 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:17579 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1750812AbWBQV0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 16:26:06 -0500
Message-ID: <43F64CC2.2010303@wolfmountaingroup.com>
Date: Fri, 17 Feb 2006 15:22:58 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: C/H/S from user space
References: <Pine.LNX.4.61.0602171157140.8950@chaos.analogic.com> <43F617FA.2030609@wolfmountaingroup.com> <Pine.LNX.4.61.0602171452520.4290@chaos.analogic.com> <43F63A59.6090401@cfl.rr.com>
In-Reply-To: <43F63A59.6090401@cfl.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's the code to calculate that as well -- from NetWare -- with int 13 
IOCTL calls and from within Windows 98.  This code builds on the djgcc DOS
version og GNU tools.

Jeff

#if (DOS_UTIL)

#define READ_DEVICE   0x02
#define WRITE_DEVICE  0x03
#define NO_VERIFY     0x00
#define WRITE_VERIFY  0x01

// convert cylinder/head/sector addressing to LBA

ULONG CHStoLBA(ULONG disk, LONGLONG cyl, ULONG head, ULONG sector)
{
    register ULONG lba;
    ULONG heads = SystemDisk[disk]->TracksPerCylinder;
    ULONG sectors = SystemDisk[disk]->SectorsPerTrack;

    lba = cyl * (heads * sectors);
    lba += (head * sectors);
    lba += sector;
    lba -= 1;    // CHS is 1 relative so adjust LBA by subtracting 1

    return lba;

}

// convert LBA to cylinder/head/sector addressing

ULONG LBAtoCHS(ULONG disk, ULONG lba, LONGLONG *cyl, ULONG *head,
           ULONG *sector)
{
    ULONG offset;
    ULONG heads = SystemDisk[disk]->TracksPerCylinder;
    ULONG sectors = SystemDisk[disk]->SectorsPerTrack;

    if (!cyl || !head || !sector)
       return -1;

    *cyl = (lba / (heads * sectors));
    offset = lba % (heads * sectors);
    *head = (WORD)(offset / sectors);
    *sector = (WORD)(offset % sectors) + 1;  // sector addressing is
                         // 1 relative so add 1
    return 0;
}

ULONG pReadDiskSectors(ULONG disk, ULONG StartingLBA, BYTE *Sector,
              ULONG sectors, ULONG readAhead)
{
    register ULONG bps, ccode, bytes = 0;
    register NWDISK *NWDisk;
    LONGLONG cylinder;
    ULONG head, sector;
    static _go32_dpmi_registers r;
#if (WINDOWS_98_UTIL)
    static union REGS rl;
#endif

    NWFSSet(&r, 0, sizeof(_go32_dpmi_registers));

    NWDisk = SystemDisk[disk];
    bps = NWDisk->BytesPerSector;

    if ((sectors * bps) > IO_BLOCK_SIZE)
       return bytes;

#if (WINDOWS_98_UTIL)
    rl.x.ax = 0x440D;    // generic IOCTL
    rl.h.bh = 3;         // locks levels 0, 1, 2 or 3
    rl.h.bl = (0x80 | (disk & 0x7F)); // dos limit is 128 drives
    rl.h.ch = 0x08;      // device category
    rl.h.cl = 0x4B;      // lock physical volume
    rl.x.dx = 0;         // permissions
    int86(0x21, &rl, &rl);

#endif

    if (NWDisk->Int13Extensions)
    {
       EXT_REQUEST request;

       NWFSSet(&request, 0, sizeof(EXT_REQUEST));

       request.Size = sizeof(EXT_REQUEST);
       request.Blocks = sectors;
       request.TransferBuffer = (ULONG)(NWDisk->DataSegment << 16) & 
0xFFFF0000;
       request.LBA = StartingLBA;

       movedata(_my_ds(),
        (unsigned)&request,
        NWDisk->RequestSelector,
        0,
        sizeof(EXT_REQUEST));

       r.h.ah = 0x42;
       r.h.dl = (0x80 | (disk & 0x7F));
       r.x.ds = NWDisk->RequestSegment;
       r.x.si = 0;
       r.x.ss = r.x.sp = r.x.flags = 0;

       ccode = _go32_dpmi_simulate_int(0x13, &r);
       if (ccode)
      goto ReadExit;

       // error if carry flag is set
       if (r.x.flags & 1)
       {
      // if the drive reported an ECC occurred, return success
      if (r.h.ah == 0x11)
      {
        movedata(NWDisk->DataSelector,
             0,
             _my_ds(),
             (unsigned)Sector,
             (sectors * bps));

        bytes = (sectors * bps);
        goto ReadExit;
      }
      else
         goto ReadExit;
       }

       movedata(NWDisk->DataSelector,
        0,
        _my_ds(),
        (unsigned)Sector,
        (sectors * bps));

       bytes = (sectors * bps);
       goto ReadExit;
    }
    else
    {
       ccode = LBAtoCHS(disk, StartingLBA, &cylinder, &head, &sector);
       if (ccode)
      goto ReadExit;

       r.h.dh = (BYTE)head;
       r.h.dl = (0x80 | (disk & 0x7F));
       r.h.ch = (BYTE)(cylinder & 0xFF);
       r.h.cl = (BYTE)((cylinder & 0x0300) >> 2);
       r.h.cl |= (BYTE)(sector & 0x3F);
       r.h.ah = READ_DEVICE;
       r.h.al = (BYTE)sectors;
       r.x.es = NWDisk->DataSegment;
       r.x.bx = 0;
       r.x.ss = r.x.sp = r.x.flags = 0;

       ccode = _go32_dpmi_simulate_int(0x13, &r);
       if (ccode)
      goto ReadExit;

       // error if carry flag is set
       if (r.x.flags & 1)
       {
      // if the drive reported an ECC occurred, return success
      if (r.h.ah == 0x11)
      {
         movedata(NWDisk->DataSelector,
             0,
             _my_ds(),
             (unsigned)Sector,
             (sectors * bps));

         bytes = (sectors * bps);
         goto ReadExit;
      }
      else
         goto ReadExit;
       }

       movedata(NWDisk->DataSelector,
        0,
        _my_ds(),
        (unsigned)Sector,
        (sectors * bps));

       bytes = (sectors * bps);
    }

ReadExit:;
#if (WINDOWS_98_UTIL)
    rl.x.ax = 0x440D;    // generic IOCTL
    rl.h.bl = (0x80 | (disk & 0x7F)); // dos limit is 128 drives
    rl.h.ch = 0x08;      // device category
    rl.h.cl = 0x6B;      // unlock physical volume
    int86(0x21, &rl, &rl);
#endif

    return bytes;

}


ULONG pWriteDiskSectors(ULONG disk, ULONG StartingLBA, BYTE *Sector,
               ULONG sectors, ULONG readAhead)
{
    register ULONG bps, ccode, bytes = 0;
    register NWDISK *NWDisk;
    LONGLONG cylinder;
    ULONG head, sector;
    static _go32_dpmi_registers r;
#if (WINDOWS_98_UTIL)
    static union REGS rl;
#endif

    NWFSSet(&r, 0, sizeof(_go32_dpmi_registers));

    NWDisk = SystemDisk[disk];
    bps = NWDisk->BytesPerSector;

    if ((sectors * bps) > IO_BLOCK_SIZE)
       return bytes;

#if (WINDOWS_98_UTIL)
    rl.x.ax = 0x440D;    // generic IOCTL
    rl.h.bh = 3;         // locks levels 0, 1, 2 or 3
    rl.h.bl = (0x80 | (disk & 0x7F)); // dos limit is 128 drives
    rl.h.ch = 0x08;      // device category
    rl.h.cl = 0x4B;      // lock physical volume
    rl.x.dx = 0;         // permissions
    int86(0x21, &rl, &rl);

#endif

    if (NWDisk->Int13Extensions)
    {
       EXT_REQUEST request;

       NWFSSet(&request, 0, sizeof(EXT_REQUEST));

       request.Size = sizeof(EXT_REQUEST);
       request.Blocks = sectors;
       request.TransferBuffer = (ULONG)(NWDisk->DataSegment << 16) & 
0xFFFF0000;
       request.LBA = StartingLBA;

       movedata(_my_ds(),
        (unsigned)&request,
        NWDisk->RequestSelector,
        0,
        sizeof(EXT_REQUEST));

       movedata(_my_ds(),
        (unsigned)Sector,
        NWDisk->DataSelector,
        0,
        (sectors * bps));

       r.h.ah = 0x43;
       r.h.al = NO_VERIFY;
       r.h.dl = (0x80 | (disk & 0x7F));
       r.x.ds = NWDisk->RequestSegment;
       r.x.si = 0;
       r.x.ss = r.x.sp = r.x.flags = 0;

       ccode = _go32_dpmi_simulate_int(0x13, &r);
       if (ccode)
      goto WriteExit;

       // error if carry flag is set
       if (r.x.flags & 1)
       {
      // if the drive reported an ECC occurred, return success
      if (r.h.ah == 0x11)
      {
         bytes = (sectors * bps);
         goto WriteExit;
      }
      else
         goto WriteExit;
       }
       bytes = (sectors * bps);
       goto WriteExit;
    }
    else
    {
       ccode = LBAtoCHS(disk, StartingLBA, &cylinder, &head, &sector);
       if (ccode)
      goto WriteExit;

       movedata(_my_ds(),
        (unsigned)Sector,
        NWDisk->DataSelector,
        0,
        (sectors * bps));

       r.h.dh = (BYTE)head;
       r.h.dl = (0x80 | (disk & 0x7F));
       r.h.ch = (BYTE)(cylinder & 0xFF);
       r.h.cl = (BYTE)((cylinder & 0x0300) >> 2);
       r.h.cl |= (BYTE)(sector & 0x3F);
       r.h.ah = WRITE_DEVICE;
       r.h.al = (BYTE)sectors;
       r.x.es = NWDisk->DataSegment;
       r.x.bx = 0;
       r.x.ds = r.x.ss = r.x.sp = r.x.flags = 0;

       ccode = _go32_dpmi_simulate_int(0x13, &r);
       if (ccode)
      goto WriteExit;

       // error if carry flag is set
       if (r.x.flags & 1)
       {
      // if the drive reported an ECC occurred, return success
      if (r.h.ah == 0x11)
      {
         bytes = (sectors * bps);
         goto WriteExit;
      }
      else
         goto WriteExit;
       }
       bytes = (sectors * bps);
       goto WriteExit;
    }

WriteExit:;
#if (WINDOWS_98_UTIL)
    rl.x.ax = 0x440D;    // generic IOCTL
    rl.h.bl = (0x80 | (disk & 0x7F)); // dos limit is 128 drives
    rl.h.ch = 0x08;      // device category
    rl.h.cl = 0x6B;      // unlock physical volume
    int86(0x21, &rl, &rl);
#endif

    return bytes;
}

ULONG pZeroFillDiskSectors(ULONG disk, ULONG StartingLBA, ULONG sectors,
              ULONG readAhead)
{
    register ULONG bps, ccode, bytes = 0;
    register NWDISK *NWDisk;
    LONGLONG cylinder;
    ULONG head, sector;
    static _go32_dpmi_registers r;
#if (WINDOWS_98_UTIL)
    static union REGS rl;
#endif

    NWFSSet(&r, 0, sizeof(_go32_dpmi_registers));

    NWDisk = SystemDisk[disk];
    bps = NWDisk->BytesPerSector;

    if ((sectors * bps) > IO_BLOCK_SIZE)
       return bytes;

    movedata(_my_ds(),
         (unsigned)ZeroBuffer,
         NWDisk->DataSelector,
         0,
         (sectors * bps));

#if (WINDOWS_98_UTIL)
    rl.x.ax = 0x440D;    // generic IOCTL
    rl.h.bh = 3;         // locks levels 0, 1, 2 or 3
    rl.h.bl = (0x80 | (disk & 0x7F)); // dos limit is 128 drives
    rl.h.ch = 0x08;      // device category
    rl.h.cl = 0x4B;      // lock physical volume
    rl.x.dx = 0;         // permissions
    int86(0x21, &rl, &rl);

#endif

    if (NWDisk->Int13Extensions)
    {
       EXT_REQUEST request;

       NWFSSet(&request, 0, sizeof(EXT_REQUEST));

       request.Size = sizeof(EXT_REQUEST);
       request.Blocks = sectors;
       request.TransferBuffer = (ULONG)(NWDisk->DataSegment << 16) & 
0xFFFF0000;
       request.LBA = StartingLBA;

       movedata(_my_ds(),
        (unsigned)&request,
        NWDisk->RequestSelector,
        0,
        sizeof(EXT_REQUEST));

       r.h.ah = 0x43;
       r.h.al = NO_VERIFY;
       r.h.dl = (0x80 | (disk & 0x7F));
       r.x.ds = NWDisk->RequestSegment;
       r.x.si = 0;
       r.x.ss = r.x.sp = r.x.flags = 0;

       ccode = _go32_dpmi_simulate_int(0x13, &r);
       if (ccode)
      goto FillExit;

       // error if carry flag is set
       if (r.x.flags & 1)
       {
      // if the drive reported an ECC occurred, return success
      if (r.h.ah == 0x11)
      {
         bytes = (sectors * bps);
         goto FillExit;
      }
      else
         goto FillExit;
       }
       bytes = (sectors * bps);
       goto FillExit;
    }
    else
    {
       ccode = LBAtoCHS(disk, StartingLBA, &cylinder, &head, &sector);
       if (ccode)
      goto FillExit;

       r.h.dh = (BYTE)head;
       r.h.dl = (0x80 | (disk & 0x7F));
       r.h.ch = (BYTE)(cylinder & 0xFF);
       r.h.cl = (BYTE)((cylinder & 0x0300) >> 2);
       r.h.cl |= (BYTE)(sector & 0x3F);
       r.h.ah = 0x03;
       r.h.al = (BYTE)sectors;
       r.x.es = NWDisk->DataSegment;
       r.x.bx = 0;
       r.x.ds = r.x.ss = r.x.sp = r.x.flags = 0;

       ccode = _go32_dpmi_simulate_int(0x13, &r);
       if (ccode)
      goto FillExit;

       // error if carry flag is set
       if (r.x.flags & 1)
       {
      // if the drive reported an ECC occurred, return success
      if (r.h.ah == 0x11)
      {
         bytes = (sectors * bps);
         goto FillExit;
      }
      else
         goto FillExit;
       }
       bytes = (sectors * bps);
       goto FillExit;
    }

FillExit:;
#if (WINDOWS_98_UTIL)
    rl.x.ax = 0x440D;    // generic IOCTL
    rl.h.bl = (0x80 | (disk & 0x7F)); // dos limit is 128 drives
    rl.h.ch = 0x08;      // device category
    rl.h.cl = 0x6B;      // unlock physical volume
    int86(0x21, &rl, &rl);
#endif

    return bytes;

}

void ScanDiskDevices(void)
{
    register ULONG j, i, retCode;
    BYTE *Sector;
    static union REGS r;
    DRIVE_INFO dinfo;

    Sector = NWFSIOAlloc(IO_BLOCK_SIZE, DISKBUF_TAG);
    if (!Sector)
    {
       NWFSPrint("nwfs:  allocation error in AddDiskDevices\n");
       return;
    }

    for (FirstValidDisk = (ULONG)-1, j = 0; j < MAX_DOS_DISKS; j++)
    {

#if (WINDOWS_98_UTIL)
       r.x.ax = 0x440D;    // generic IOCTL
       r.h.bh = 1;         // locks levels 0, 1, 2 or 3
       r.h.bl = (0x80 | (j & 0x7F)); // dos limit is 128 drives
       r.h.ch = 0x08;      // device category
       r.h.cl = 0x4B;      // lock physical volume
       r.x.dx = 1;         // permissions
       r.h.cflag = 0x0001;

       int86(0x21, &r, &r);
#endif

       // test fixed disk status
       r.h.ah = 0x10;  // test drive status
       r.h.dl = (0x80 | (j & 0x7F)); // dos limit is 128 drives
       int86(0x13, &r, &r);

       // if we got the drive status, and the drive is active,
       // assume the disk is valid.
       if ((!r.h.cflag) && (!r.h.ah))
       {
          // now check if this device supports removable media.  This
      // would indicate this device is a CDROM drive.  If we detect
          // that this device supports removable meida, then do not
          // add it -- it's most likely a CDROM or tape device and
      // we should not add it.

          // see if a change line is available for this device.
          r.h.ah = 0x15;  // test drive status
          r.h.dl = (0x80 | (j & 0x7F)); // dos limit is 128 drives
          int86(0x13, &r, &r);

          // 00-no drive, 01-diskette, 02-change line, 03-fixed disk
      if (r.h.ch == 0x02)
      {

#if (WINDOWS_98_UTIL)
         r.x.ax = 0x440D;    // generic IOCTL
         r.h.bl = (0x80 | (j & 0x7F)); // dos limit is 128 drives
         r.h.ch = 0x08;      // device category
         r.h.cl = 0x6B;      // unlock physical volume
         int86(0x21, &r, &r);
#endif
         continue;
      }

      if (!SystemDisk[j])
      {
         SystemDisk[j] = (NWDISK *) NWFSAlloc(sizeof(NWDISK), NWDISK_TAG);
         if (!SystemDisk[j])
         {
        NWFSPrint("nwfs: memory allocation failure in AddDiskDevices\n");

#if (WINDOWS_98_UTIL)
        r.x.ax = 0x440D;    // generic IOCTL
        r.h.bl = (0x80 | (j & 0x7F)); // dos limit is 128 drives
        r.h.ch = 0x08;      // device category
        r.h.cl = 0x6B;      // unlock physical volume
        int86(0x21, &r, &r);
#endif
        continue;
         }
         NWFSSet(SystemDisk[j], 0, sizeof(NWDISK));
      }

      SystemDisk[j]->PhysicalDiskHandle = (void *)(0x80 | (j & 0x7F));
      SystemDisk[j]->DiskNumber = j;
      SystemDisk[j]->Int13Extensions = Int13ExtensionsPresent(j);

      SystemDisk[j]->DataSegment =
           __dpmi_allocate_dos_memory(PARAGRAPH_ALIGN(IO_BLOCK_SIZE),
                      &SystemDisk[j]->DataSelector);
      if (SystemDisk[j]->DataSegment == (WORD) -1)
      {
         SystemDisk[j]->PhysicalDiskHandle = 0;
         NWFSFree(SystemDisk[j]);
         SystemDisk[j] = 0;

#if (WINDOWS_98_UTIL)
         r.x.ax = 0x440D;    // generic IOCTL
         r.h.bl = (0x80 | (j & 0x7F)); // dos limit is 128 drives
         r.h.ch = 0x08;      // device category
         r.h.cl = 0x6B;      // unlock physical volume
         int86(0x21, &r, &r);
#endif
         continue;
      }

      SystemDisk[j]->DriveInfoSegment =
           __dpmi_allocate_dos_memory(PARAGRAPH_ALIGN(IO_BLOCK_SIZE),
                      &SystemDisk[j]->DriveInfoSelector);
      if (SystemDisk[j]->DriveInfoSegment == (WORD) -1)
      {
         if (SystemDisk[j]->DataSelector)
        __dpmi_free_dos_memory(SystemDisk[j]->DataSelector);
         SystemDisk[j]->DataSelector = 0;

         SystemDisk[j]->PhysicalDiskHandle = 0;
         NWFSFree(SystemDisk[j]);
         SystemDisk[j] = 0;

#if (WINDOWS_98_UTIL)
         r.x.ax = 0x440D;    // generic IOCTL
         r.h.bl = (0x80 | (j & 0x7F)); // dos limit is 128 drives
         r.h.ch = 0x08;      // device category
         r.h.cl = 0x6B;      // unlock physical volume
         int86(0x21, &r, &r);
#endif
         continue;
      }

      SystemDisk[j]->RequestSegment =
           __dpmi_allocate_dos_memory(PARAGRAPH_ALIGN(sizeof(EXT_REQUEST)),
                      &SystemDisk[j]->RequestSelector);
      if (SystemDisk[j]->RequestSegment == (WORD) -1)
      {
         if (SystemDisk[j]->DataSelector)
        __dpmi_free_dos_memory(SystemDisk[j]->DataSelector);
         SystemDisk[j]->DataSelector = 0;

         if (SystemDisk[j]->DriveInfoSelector)
        __dpmi_free_dos_memory(SystemDisk[j]->DriveInfoSelector);
         SystemDisk[j]->DriveInfoSelector = 0;

         SystemDisk[j]->PhysicalDiskHandle = 0;
         NWFSFree(SystemDisk[j]);
         SystemDisk[j] = 0;

#if (WINDOWS_98_UTIL)
         r.x.ax = 0x440D;    // generic IOCTL
         r.h.bl = (0x80 | (j & 0x7F)); // dos limit is 128 drives
         r.h.ch = 0x08;      // device category
         r.h.cl = 0x6B;      // unlock physical volume
         int86(0x21, &r, &r);
#endif
         continue;
      }

      // if int 13 extensions are present, then adjust drive geometry
      // based on reported drive info.

      if (SystemDisk[j]->Int13Extensions)
      {
         register ULONG cylinders, heads, sectors;
         _go32_dpmi_registers r32;

         NWFSSet(&r32, 0, sizeof(_go32_dpmi_registers));
         NWFSSet(&dinfo, 0, sizeof(DRIVE_INFO));

         dinfo.Size = sizeof(DRIVE_INFO);

         movedata(_my_ds(), (unsigned)&dinfo,
              SystemDisk[j]->DriveInfoSelector, 0,
              sizeof(DRIVE_INFO));

         // get int 13 extension drive info
         r32.h.ah = 0x48;
         r32.h.dl = (0x80 | (j & 0x7F));
         r32.x.si = 0;
         r32.x.ds = SystemDisk[j]->DriveInfoSegment;

         _go32_dpmi_simulate_int(0x13, &r32);

         movedata(SystemDisk[j]->DriveInfoSelector, 0,
              _my_ds(), (unsigned)&dinfo,
              sizeof(DRIVE_INFO));

         // if TotalSectors is 0, then there are no drives
         // attached to this controller.

         if (!dinfo.TotalSectors)
         {
        if (SystemDisk[j]->RequestSelector)
           __dpmi_free_dos_memory(SystemDisk[j]->RequestSelector);
        SystemDisk[j]->RequestSelector = 0;

        if (SystemDisk[j]->DataSelector)
           __dpmi_free_dos_memory(SystemDisk[j]->DataSelector);
        SystemDisk[j]->DataSelector = 0;

        if (SystemDisk[j]->DriveInfoSelector)
           __dpmi_free_dos_memory(SystemDisk[j]->DriveInfoSelector);
        SystemDisk[j]->DriveInfoSelector = 0;

        SystemDisk[j]->PhysicalDiskHandle = 0;
        NWFSFree(SystemDisk[j]);
        SystemDisk[j] = 0;

#if (WINDOWS_98_UTIL)
        r.x.ax = 0x440D;    // generic IOCTL
        r.h.bl = (0x80 | (j & 0x7F)); // dos limit is 128 drives
        r.h.ch = 0x08;      // device category
        r.h.cl = 0x6B;      // unlock physical volume
        int86(0x21, &r, &r);
#endif
        continue;
         }

         r.h.ah = 0x08;   // read drive parameters
         r.h.dl = (0x80 | (j & 0x7F));

         int86(0x13, &r, &r);

         if (r.h.cflag)
         {
        if (SystemDisk[j]->RequestSelector)
           __dpmi_free_dos_memory(SystemDisk[j]->RequestSelector);
        SystemDisk[j]->RequestSelector = 0;

        if (SystemDisk[j]->DataSelector)
           __dpmi_free_dos_memory(SystemDisk[j]->DataSelector);
        SystemDisk[j]->DataSelector = 0;

        if (SystemDisk[j]->DriveInfoSelector)
           __dpmi_free_dos_memory(SystemDisk[j]->DriveInfoSelector);
        SystemDisk[j]->DriveInfoSelector = 0;

        SystemDisk[j]->PhysicalDiskHandle = 0;
        NWFSFree(SystemDisk[j]);
        SystemDisk[j] = 0;

#if (WINDOWS_98_UTIL)
        r.x.ax = 0x440D;    // generic IOCTL
        r.h.bl = (0x80 | (j & 0x7F)); // dos limit is 128 drives
        r.h.ch = 0x08;      // device category
        r.h.cl = 0x6B;      // unlock physical volume
        int86(0x21, &r, &r);
#endif
        continue;
         }

         // translate drive geometry based on the total sectors
         // reported by the Int 13 extension procedure.

         heads = r.h.dh + 1;
         sectors = ((WORD)r.h.cl & 0x003F);
         cylinders = (dinfo.TotalSectors / (heads * sectors));

         // make sure that cylinders are within the maximum value
         // allowed by the Int 13 Extended Architecture.  At present,
         // this limit is 16 mega-tera sectors (2^64).

         // assume the current IDE limits for cylinder count
         if (cylinders > (ULONG) 65536)
         {
        if (SystemDisk[j]->RequestSelector)
           __dpmi_free_dos_memory(SystemDisk[j]->RequestSelector);
        SystemDisk[j]->RequestSelector = 0;

        if (SystemDisk[j]->DataSelector)
           __dpmi_free_dos_memory(SystemDisk[j]->DataSelector);
        SystemDisk[j]->DataSelector = 0;

        if (SystemDisk[j]->DriveInfoSelector)
           __dpmi_free_dos_memory(SystemDisk[j]->DriveInfoSelector);
        SystemDisk[j]->DriveInfoSelector = 0;

        SystemDisk[j]->PhysicalDiskHandle = 0;
        NWFSFree(SystemDisk[j]);
        SystemDisk[j] = 0;

#if (WINDOWS_98_UTIL)
        r.x.ax = 0x440D;    // generic IOCTL
        r.h.bl = (0x80 | (j & 0x7F)); // dos limit is 128 drives
        r.h.ch = 0x08;      // device category
        r.h.cl = 0x6B;      // unlock physical volume
        int86(0x21, &r, &r);
#endif
        continue;
         }

         //   Use the Phoenix method of drive translation
         //   to translate drive geometry for those drives
         //   that exceed 1024 cylinders in size.
         //
         //   Phoenix Geometry Translation Table
         //   -----------------------------------
         //
         //   Phys Cylinders    Phys Heads  Trans Cyl Trans Heads  Max
         //    --------------------------------------------------------
         //   1     <C<= 1024    1 <H<= 16   C = C     H = H     528 MB
         //   1024  <C<= 2048    1 <H<= 16   C = C/2   H = H*2   1.0 GB
         //   2048  <C<= 4096    1 <H<= 16   C = C/4   H = H*4   2.1 GB
         //   4096  <C<= 8192    1 <H<= 16   C = C/8   H = H*8   4.2 GB
         //   8192  <C<= 16384   1 <H<= 16   C = C/16  H = H*16  8.4 GB
         //   16384 <C<= 32768   1 <H<= 8    C = C/32  H = H*32  8.4 GB
         //   32768 <C<= 65536   1 <H<= 4    C = C/64  H = H*64  8.4 GB
         //
         //   LBA Assisted Translation Table
         //   ------------------------------
         //
         //   (NOTE:  The method below is an alternate method for
         //   translating large drives that does not place any limits
         //   on reported drive geometry.  It has the disadvantage
         //   of always assuming 63 Sectors Per Track.)
         //
         //   Range              Sectors  Heads   Cylinders
         //   -----------------------------------------------------
         //   1 MB   <X< 528 MB    63       16    X/(63 * 16 * 512)
         //   528 MB <X< 1.0 GB    63       32    X/(63 * 32 * 512)
         //   1.0 GB <X< 2.1 GB    63       64    X/(63 * 64 * 512)
         //   2.1 GB <X< 4.2 GB    63      128    X/(63 * 128 * 512)
         //   4.2 GB <X< 8.4 GB    63      255    X/(63 * 255 * 512)
         //

         // Adjust cylinder and head dimensions until this drive
         // presents a geometry with a cylinder count that is less
         // than 1024 or Heads less than or equal to 255.

         if (cylinders >= 1024)
         {
        while ((heads * 2) <= 256)
        {
           heads *= 2;
           cylinders /= 2;
           if (cylinders < 1024)
              break;
        }
         }

             if (FirstValidDisk == (ULONG)-1)
                FirstValidDisk = j;

         SystemDisk[j]->BytesPerSector = 512;
         SystemDisk[j]->Cylinders = (LONGLONG) cylinders;
         SystemDisk[j]->TracksPerCylinder = heads;
         SystemDisk[j]->SectorsPerTrack = sectors;
         SystemDisk[j]->driveSize = (LONGLONG)
                  (SystemDisk[j]->Cylinders *
                   SystemDisk[j]->TracksPerCylinder *
                   SystemDisk[j]->SectorsPerTrack *
                   SystemDisk[j]->BytesPerSector);
#if (VERBOSE)
         NWFSPrint("disk-%d cyl-%d head-%d sector-%d (Int 13)\n",
              (int)j,
              (int)SystemDisk[j]->Cylinders,
              (int)SystemDisk[j]->TracksPerCylinder,
              (int)SystemDisk[j]->SectorsPerTrack);
#endif
      }
      else
      {
         // query the drive parameters with standard bios
         r.h.ah = 0x08;
         r.h.dl = (0x80 | (j & 0x7F));

         int86(0x13, &r, &r);

         if (r.h.cflag)
         {
        if (SystemDisk[j]->RequestSelector)
           __dpmi_free_dos_memory(SystemDisk[j]->RequestSelector);
        SystemDisk[j]->RequestSelector = 0;

        if (SystemDisk[j]->DataSelector)
           __dpmi_free_dos_memory(SystemDisk[j]->DataSelector);
        SystemDisk[j]->DataSelector = 0;

        if (SystemDisk[j]->DriveInfoSelector)
           __dpmi_free_dos_memory(SystemDisk[j]->DriveInfoSelector);
        SystemDisk[j]->DriveInfoSelector = 0;

        SystemDisk[j]->PhysicalDiskHandle = 0;
        NWFSFree(SystemDisk[j]);
        SystemDisk[j] = 0;

#if (WINDOWS_98_UTIL)
        r.x.ax = 0x440D;    // generic IOCTL
        r.h.bl = (0x80 | (j & 0x7F)); // dos limit is 128 drives
        r.h.ch = 0x08;      // device category
        r.h.cl = 0x6B;      // unlock physical volume
        int86(0x21, &r, &r);
#endif
        continue;
         }

             if (FirstValidDisk == (ULONG)-1)
                FirstValidDisk = j;

         SystemDisk[j]->BytesPerSector = 512;
         SystemDisk[j]->Cylinders =
         (LONGLONG)(((WORD)((WORD)r.h.cl << 2) & 0x0300) |
                (WORD)r.h.ch) + 1;
         SystemDisk[j]->TracksPerCylinder = (r.h.dh + 1);
         SystemDisk[j]->SectorsPerTrack = ((WORD)r.h.cl & 0x003F);
         SystemDisk[j]->driveSize = (LONGLONG)
                  (SystemDisk[j]->Cylinders *
                   SystemDisk[j]->TracksPerCylinder *
                   SystemDisk[j]->SectorsPerTrack *
                   SystemDisk[j]->BytesPerSector);
#if (VERBOSE)
         NWFSPrint("disk-%d cyl-%d head-%d sector-%d\n",
              (int)j,
              (int)SystemDisk[j]->Cylinders,
              (int)SystemDisk[j]->TracksPerCylinder,
              (int)SystemDisk[j]->SectorsPerTrack);
#endif
      }

#if (WINDOWS_98_UTIL)
      r.x.ax = 0x440D;    // generic IOCTL
      r.h.bl = (0x80 | (j & 0x7F)); // dos limit is 128 drives
      r.h.ch = 0x08;      // device category
      r.h.cl = 0x6B;      // unlock physical volume
      int86(0x21, &r, &r);
#endif
      TotalDisks++;
      if (TotalDisks > MaximumDisks)
         MaximumDisks = TotalDisks;

      retCode = ReadDiskSectors(j, 0, Sector,
             IO_BLOCK_SIZE / SystemDisk[j]->BytesPerSector,
             IO_BLOCK_SIZE / SystemDisk[j]->BytesPerSector);
      if (!retCode)
      {
         NWFSPrint("nwfs:  disk-%d read error in ScanDiskDevices\n", 
(int)j);
         continue;
      }

      NWFSCopy(&SystemDisk[j]->partitionSignature, &Sector[0x01FE], 2);

      if (SystemDisk[j]->partitionSignature != 0xAA55)
      {
#if (VERBOSE)
         NWFSPrint("nwfs:  partition signature 0xAA55 not found 
disk(%d)\n", (int)j);
#endif
         NWFSSet(&SystemDisk[j]->PartitionTable[0].fBootable, 0, 64);
         continue;
      }
      else
      {
         NWFSCopy(&SystemDisk[j]->PartitionTable[0].fBootable,
              &Sector[0x01BE], 64);
      }

      // scan for Netware Partitions and detect 3.x and 4.x/5.x 
partition types
      for (i=0, SystemDisk[j]->NumberOfPartitions = 0; i < 4; i++)
      {
         if (SystemDisk[j]->PartitionTable[i].nSectorsTotal)
                SystemDisk[j]->NumberOfPartitions++;           

         if (SystemDisk[j]->PartitionTable[i].SysFlag == NETWARE_386_ID)
         {
        retCode = ReadDiskSectors(j,
                 SystemDisk[j]->PartitionTable[i].StartLBA,
                 Sector,
                 IO_BLOCK_SIZE / SystemDisk[j]->BytesPerSector,
                 IO_BLOCK_SIZE / SystemDisk[j]->BytesPerSector);
        if (!retCode)
        {
           NWFSPrint("nwfs:  disk-%d read error in ScanDiskDevices 
(part)\n", (int)j);
           continue;
        }

        if (!NWFSCompare(Sector, NwPartSignature, 16))
           SystemDisk[j]->PartitionVersion[i] = NW4X_PARTITION;
        else
           SystemDisk[j]->PartitionVersion[i] = NW3X_PARTITION;
         }
      }
       }
    }
    NWFSFree(Sector);
    return;
}

Phillip Susi wrote:

> linux-os (Dick Johnson) wrote:
>
>>
>> Yes, it's a very good model, in fact what I've been talking about.
>> However, several people who refused to read or understand, insisted
>> upon obtaining the exact same C/H/S that the machine claimed to
>> use when it was booted.
>>
>
> That's because if you don't use the same geometry that the bios 
> reports when calculating the CHS addresses of the sectors you intend 
> to load, you won't be requesting the right sectors from int 13.
>
>> So, since Linux doesn't destroy that information remaining in
>> the BIOS tables, I show how to make it available to a 'root' user.
>> Observation over several machines will show that the BIOS always
>> uses the same stuff for large media and, in fact, it has no choice.
>> Basically, this means that the first part of the boot-code, the
>> stuff that needs to be translated to fit into the int 0x13 registers,
>> needs to be below 1024 cylinders, 63 sectors-track, and 256 heads.
>> Trivial... even LILO was able to do that! Once the machine boots
>> past the requirement to use the BIOS services, it's a CHS=NOP.
>>
>
> Generally yes, modern large disks will get clamped at 1024 cylinders, 
> 255 heads, and 63 sectors.  You seem to be arguing that this will 
> always be the case.  If that is so, then the kernel doesn't need to 
> store these values since it is known a priori does it?  But it isn't 
> always going to be 255/63, there are some bioses ( I forget which ) 
> that cap the number of heads at 240, and disks that are smaller than 8 
> gigs also will have less than 255 heads.
>
>
>

