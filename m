Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbULLWA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbULLWA4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 17:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbULLWA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 17:00:56 -0500
Received: from ctb-mesg6.saix.net ([196.25.240.78]:49907 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S262135AbULLWAb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 17:00:31 -0500
Subject: Re: [WISHLIST] IBM HD Shock detection in Linux
From: Niel Lambrechts <antispam@telkomsa.net>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-aJSoCAltkLJIgu+fBgoR"
Date: Mon, 13 Dec 2004 00:01:22 +0200
Message-Id: <1102888882.15558.2.camel@ksyrium.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aJSoCAltkLJIgu+fBgoR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I picked this up from somewhere on the net, pity that it is not c
code...

The code apparently can display the horizon, but cannot prevent
shocks :(

-- 
Niel Lambrechts <antispam@telkomsa.net>

--=-aJSoCAltkLJIgu+fBgoR
Content-Disposition: attachment; filename=horizon.cs
Content-Type: text/x-csharp; name=horizon.cs; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

using System;
using System.IO;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using System.Runtime.InteropServices;

public sealed class Accelerometer : IDisposable
{
	private const uint GENERIC_READ = 0x80000000;
	private const uint FILE_SHARE_READ = 1;
	private const uint FILE_SHARE_WRITE = 2;
	private const uint OPEN_EXISTING = 3;
	private readonly static IntPtr INVALID_HANDLE_VALUE = new IntPtr(-1);
	private const uint IOCTL_SHOCKMGR_READ_ACCELEROMETER_DATA = 0x733fc;
	private const int FACILITY_WIN32 = unchecked((int)0x80070000);
	private IntPtr handle = INVALID_HANDLE_VALUE;
	private AccelerometerData sample;

	private static int HRESULT_FROM_WIN32(int x)
	{
		return x <= 0 ? x : ((x & 0x0000FFFF) | FACILITY_WIN32);
	}

	private struct AccelerometerData
	{
		internal int status;
		internal short x0;
		internal short y0;
		short x1;
		short y1;
		short x2;
		short y2;
		short x3;
		short y3;
		short x4;
		short y4;
		short x5;
		short y5;
		short x6;
		short y6;
		short x7;
		short y7;
		short x8;
		short y8;
		short x9;
		short y9;
		short x10;
		short y10;
		short x11;
		short y11;
		short x12;
		short y12;
		short x13;
		short y13;
		short unknown0;
		short unknown1;
	}

	[DllImport("kernel32.dll", SetLastError = true)]
	private static extern IntPtr CreateFile(string lpFileName, uint dwDesiredAccess, uint dwShareMode, IntPtr lpSecurityAttributes, uint dwCreationDisposition, uint dwFlagsAndAttributes, IntPtr hTemplateFile);

	[DllImport("kernel32.dll")]
	private static extern void CloseHandle(IntPtr handle);

	[DllImport("kernel32.dll", SetLastError = true)]
	private static extern bool DeviceIoControl(IntPtr hDevice, uint dwIoControlCode, IntPtr lpInBuffer, uint nInBufferSize, ref AccelerometerData lpOutBuffer, uint nOutBufferSize, ref uint lpBytesReturned, IntPtr lpOverlapped);

	public Accelerometer()
	{
		handle = CreateFile(@"\\.\ShockMgr", GENERIC_READ, FILE_SHARE_READ | FILE_SHARE_WRITE, IntPtr.Zero, OPEN_EXISTING, 0, IntPtr.Zero);
		if(handle == INVALID_HANDLE_VALUE)
		{
			GC.SuppressFinalize(this);
			Marshal.ThrowExceptionForHR(HRESULT_FROM_WIN32(Marshal.GetLastWin32Error()));
		}
	}

	~Accelerometer()
	{
		CloseImpl();
	}

	private void CloseImpl()
	{
		IntPtr h = handle;
		if(h != INVALID_HANDLE_VALUE)
		{
			handle = INVALID_HANDLE_VALUE;
			CloseHandle(h);
		}
	}

	public void ReadSample()
	{
		uint dwRead = 0;
		if(!DeviceIoControl(handle, IOCTL_SHOCKMGR_READ_ACCELEROMETER_DATA, IntPtr.Zero, 0, ref sample, 0x24, ref dwRead, IntPtr.Zero))
		{
			Marshal.ThrowExceptionForHR(HRESULT_FROM_WIN32(Marshal.GetLastWin32Error()));
		}
	}

	public int Status
	{
		get
		{
			return sample.status;
		}
	}

	public int X
	{
		get
		{
			return sample.x0;
		}
	}

	public int Y
	{
		get
		{
			return sample.y0;
		}
	}

	public void Dispose()
	{
		CloseImpl();
		GC.SuppressFinalize(this);
	}
}

namespace Horizon
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class Form1 : System.Windows.Forms.Form
	{
		private System.ComponentModel.IContainer components;
		private System.Windows.Forms.Timer timer1;
		private Accelerometer sensor = new Accelerometer();

		public Form1()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			//
			// TODO: Add any constructor code after InitializeComponent call
			//

		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if (components != null) 
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.components = new System.ComponentModel.Container();
			this.timer1 = new System.Windows.Forms.Timer(this.components);
			// 
			// timer1
			// 
			this.timer1.Enabled = true;
			this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
			// 
			// Form1
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(292, 266);
			this.Name = "Form1";
			this.Text = "Form1";

		}
		#endregion

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main() 
		{
			Application.Run(new Form1());
		}

		private void timer1_Tick(object sender, System.EventArgs e)
		{
			sensor.ReadSample();
			Invalidate();
		}

		protected override void OnPaint(PaintEventArgs e)
		{
			base.OnPaint(e);
			float horizontal = 640;
			float vertical = 800;
			float y = sensor.Y;
			float angle = 90 * (y - horizontal) / (vertical - horizontal);
			e.Graphics.DrawString(angle.ToString(), Font, Brushes.Black, 0, 0);
			e.Graphics.TranslateTransform(ClientRectangle.Width / 2, ClientRectangle.Height / 2);
			e.Graphics.RotateTransform(- angle);
			e.Graphics.DrawLine(Pens.Black, - ClientRectangle.Width / 2, 0, ClientRectangle.Width / 2, 0);
		}
	}
}

--=-aJSoCAltkLJIgu+fBgoR--

