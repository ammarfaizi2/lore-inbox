Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265854AbSJVWgG>; Tue, 22 Oct 2002 18:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265861AbSJVWgG>; Tue, 22 Oct 2002 18:36:06 -0400
Received: from fmr03.intel.com ([143.183.121.5]:63480 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP
	id <S265854AbSJVWf7>; Tue, 22 Oct 2002 18:35:59 -0400
Date: Tue, 22 Oct 2002 15:41:59 -0700 (PDT)
From: Suresh Siddha <sbsiddha@unix-os.sc.intel.com>
To: Ulrich.Weigand@de.ibm.com
cc: jun.nakajima@intel.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fixes for building kernel using Intel compiler
In-Reply-To: <A9EA4AD6F6B9D511BBED00508B66C69A04B37747@fmsmsx111.fm.intel.com>
Message-ID: <Pine.LNX.4.44.0210221438170.20605-100000@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Ulrich Weigand [mailto:Ulrich.Weigand@de.ibm.com]
> Sent: Monday, October 21, 2002 11:29 AM
> To: jun.nakajima@intel.com
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: [PATCH] fixes for building kernel using Intel compiler
> 
> 
> 
> This is a user error (sort of); you're supposed to write:
> 
> typedef struct bar_16 {
>         char xxx[3];
>         short yyy;
> } __attribute__ ((aligned (16))) bar_16_t;
> 

gcc documentation says
(http://gcc.gnu.org/onlinedocs/gcc/Type-Attributes.html#Type%20Attributes) 

<snip> 
You may specify the aligned and transparent_union attributes either in a 
typedef declaration or just past the closing curly brace of a complete 
enum, struct or union type definition and the packed attribute only past 
the closing brace of a definition 
</snip>

We tried with gcc 3.2 and  Juns test case for attribute(aligned) is 
passing. So its just probably some old gcc bug.

> Well, I guess in those files the attribute((packed)) is a no-op
> anyway as the structs are already packed according to the default
> rules, so it doesn't really matter.  It should probably still be
> fixed ...
> 

I have appended a patch for 2.5.44 which fixes this packed attribute 
issue.

thanks,
suresh

diff -Nru linux-2.5.44/arch/s390x/kernel/ptrace32.h attrib-linux/arch/s390x/kernel/ptrace32.h
--- linux-2.5.44/arch/s390x/kernel/ptrace32.h	Fri Oct 18 21:01:52 2002
+++ attrib-linux/arch/s390x/kernel/ptrace32.h	Tue Oct 22 12:03:25 2002
@@ -6,14 +6,14 @@
 typedef struct
 {
 	__u32 cr[3];
-} per_cr_words32  __attribute__((packed));
+} __attribute__((packed)) per_cr_words32;  
 
 typedef struct
 {
 	__u16          perc_atmid;          /* 0x096 */
 	__u32          address;             /* 0x098 */
 	__u8           access_id;           /* 0x0a1 */
-} per_lowcore_words32  __attribute__((packed));
+} __attribute__((packed)) per_lowcore_words32;
 
 typedef struct
 {
@@ -37,7 +37,7 @@
 	union {
 		per_lowcore_words32 words;
 	} lowcore; 
-} per_struct32 __attribute__((packed));
+} __attribute__((packed)) per_struct32;
 
 struct user_regs_struct32
 {
diff -Nru linux-2.5.44/drivers/char/ftape/lowlevel/ftape-bsm.h attrib-linux/drivers/char/ftape/lowlevel/ftape-bsm.h
--- linux-2.5.44/drivers/char/ftape/lowlevel/ftape-bsm.h	Fri Oct 18 21:00:42 2002
+++ attrib-linux/drivers/char/ftape/lowlevel/ftape-bsm.h	Mon Oct 21 15:48:58 2002
@@ -47,7 +47,7 @@
  */
 typedef struct NewSectorMap {          
 	__u8 bytes[3];
-} SectorCount __attribute__((packed));
+} __attribute__((packed)) SectorCount;
 
 
 /*
diff -Nru linux-2.5.44/drivers/net/e100/e100.h attrib-linux/drivers/net/e100/e100.h
--- linux-2.5.44/drivers/net/e100/e100.h	Fri Oct 18 21:01:20 2002
+++ attrib-linux/drivers/net/e100/e100.h	Mon Oct 21 15:45:04 2002
@@ -488,7 +488,7 @@
 	u8 scb_fc_thld;	/* Flow Control threshold */
 	u8 scb_fc_xon_xoff;	/* Flow Control XON/XOFF values */
 	u8 scb_pmdr;	/* Power Mgmt. Driver Reg */
-} d101_scb_ext __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) d101_scb_ext;
 
 /* Changed for 82559 enhancement */
 typedef struct _d101m_scb_ext_t {
@@ -504,7 +504,7 @@
 	u32 scb_function_event_mask;	/* Cardbus Function Mask */
 	u32 scb_function_present_state;	/* Cardbus Function state */
 	u32 scb_force_event;	/* Cardbus Force Event */
-} d101m_scb_ext __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) d101m_scb_ext; 
 
 /* Changed for 82550 enhancement */
 typedef struct _d102_scb_ext_t {
@@ -523,7 +523,7 @@
 	u32 scb_function_event_mask;	/* Cardbus Function Mask */
 	u32 scb_function_present_state;	/* Cardbus Function state */
 	u32 scb_force_event;	/* Cardbus Force Event */
-} d102_scb_ext __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) d102_scb_ext;
 
 /*
  * 82557 status control block. this will be memory mapped & will hang of the
@@ -545,7 +545,7 @@
 		d101m_scb_ext d101m_scb;	/* 82559 specific fields */
 		d102_scb_ext d102_scb;
 	} scb_ext;
-} scb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) scb_t;
 
 /* Self test
  * This is used to dump results of the self test 
@@ -553,7 +553,7 @@
 typedef struct _self_test_t {
 	u32 st_sign;	/* Self Test Signature */
 	u32 st_result;	/* Self Test Results */
-} self_test_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) self_test_t;
 
 /* 
  *  Statistical Counters 
@@ -636,39 +636,39 @@
 	u16 cb_status;	/* Command Block Status */
 	u16 cb_cmd;	/* Command Block Command */
 	u32 cb_lnk_ptr;	/* Link To Next CB */
-} cb_header_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) cb_header_t;
 
 //* Individual Address Command Block (IA_CB)*/
 typedef struct _ia_cb_t {
 	cb_header_t ia_cb_hdr;
 	u8 ia_addr[ETH_ALEN];
-} ia_cb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) ia_cb_t;
 
 /* Configure Command Block (CONFIG_CB)*/
 typedef struct _config_cb_t {
 	cb_header_t cfg_cbhdr;
 	u8 cfg_byte[CB_CFIG_BYTE_COUNT + CB_CFIG_D102_BYTE_COUNT];
-} config_cb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) config_cb_t;
 
 /* MultiCast Command Block (MULTICAST_CB)*/
 typedef struct _multicast_cb_t {
 	cb_header_t mc_cbhdr;
 	u16 mc_count;	/* Number of multicast addresses */
 	u8 mc_addr[(ETH_ALEN * MAX_MULTICAST_ADDRS)];
-} mltcst_cb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) mltcst_cb_t; 
 
 #define UCODE_MAX_DWORDS	134
 /* Load Microcode Command Block (LOAD_UCODE_CB)*/
 typedef struct _load_ucode_cb_t {
 	cb_header_t load_ucode_cbhdr;
 	u32 ucode_dword[UCODE_MAX_DWORDS];
-} load_ucode_cb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) load_ucode_cb_t;
 
 /* Load Programmable Filter Data*/
 typedef struct _filter_cb_t {
 	cb_header_t filter_cb_hdr;
 	u32 filter_data[MAX_FILTER];
-} filter_cb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) filter_cb_t;
 
 /* NON_TRANSMIT_CB -- Generic Non-Transmit Command Block 
  */
@@ -680,7 +680,7 @@
 		mltcst_cb_t multicast;
 		filter_cb_t filter;
 	} ntcb;
-} nxmit_cb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) nxmit_cb_t;
 
 /*Block for queuing for postponed execution of the non-transmit commands*/
 typedef struct _nxmit_cb_entry_t {
@@ -713,7 +713,7 @@
 	u32 tbd_buf_addr;	/* Physical Transmit Buffer Address */
 	u16 tbd_buf_cnt;	/* Actual Count Of Bytes */
 	u16 padd;
-} tbd_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) tbd_t;
 
 /* d102 specific fields */
 typedef struct _tcb_ipcb_t {
@@ -732,7 +732,7 @@
 		u16 tbd_zero_size;
 	} tbd_sec_size;
 	u16 total_tcp_payload;
-} tcb_ipcb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) tcb_ipcb_t;
 
 #define E100_TBD_ARRAY_SIZE (2+MAX_SKB_FRAGS)
 
@@ -795,7 +795,7 @@
 	u32 rbd_rcb_addr;	/* Receive Buffer Address */
 	u16 rbd_sz;	/* Receive Buffer Size */
 	u16 rbd_filler1;
-} rbd_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) rbd_t;
 
 /*
  * This structure is used to maintain a FIFO access to a resource that is 
diff -Nru linux-2.5.44/drivers/net/gt96100eth.h attrib-linux/drivers/net/gt96100eth.h
--- linux-2.5.44/drivers/net/gt96100eth.h	Fri Oct 18 21:01:17 2002
+++ attrib-linux/drivers/net/gt96100eth.h	Mon Oct 21 15:46:17 2002
@@ -214,7 +214,7 @@
 	u32 cmdstat;
 	u32 next;
 	u32 buff_ptr;
-} gt96100_td_t __attribute__ ((packed));
+}__attribute__ ((packed)) gt96100_td_t;
 
 typedef struct {
 #ifdef DESC_BE
@@ -227,7 +227,7 @@
 	u32 cmdstat;
 	u32 next;
 	u32 buff_ptr;
-} gt96100_rd_t __attribute__ ((packed));
+} __attribute__ ((packed)) gt96100_rd_t;
 
 
 /* Values for the Tx command-status descriptor entry. */
diff -Nru linux-2.5.44/drivers/s390/net/lcs.c attrib-linux/drivers/s390/net/lcs.c
--- linux-2.5.44/drivers/s390/net/lcs.c	Fri Oct 18 21:01:13 2002
+++ attrib-linux/drivers/s390/net/lcs.c	Mon Oct 21 15:54:58 2002
@@ -322,7 +322,7 @@
 u8		slot;
 
 typedef struct {
-lcs_header} lcs_header_type __attribute__ ((packed));
+lcs_header} __attribute__ ((packed)) lcs_header_type;
 
 enum {
 	lcs_390_initiated,
@@ -345,13 +345,13 @@
 	u8 operator_flags[3];
 	u8 reserved[3];
 	u8 command_data[0];
-} lcs_std_cmd __attribute__ ((packed));
+} __attribute__ ((packed)) lcs_std_cmd; 
 
 typedef struct {
 	lcs_header lcs_base_cmd u16 unused1;
 	u16 buff_size;
 	u8 unused2[6];
-} lcs_startup_cmd __attribute__ ((packed));
+} __attribute__ ((packed)) lcs_startup_cmd;
 
 #define LCS_ADDR_LEN 6
 
@@ -360,7 +360,7 @@
 	u32 ip_addr;
 	u8 mac_address[LCS_ADDR_LEN];
 	u8 reserved[2];
-} lcs_ip_mac_addr_pair __attribute__ ((packed));
+} __attribute__ ((packed)) lcs_ip_mac_addr_pair; 
 
 typedef enum {
 	ipm_set_required,
@@ -385,7 +385,7 @@
 	u16 version;		/* IP version i.e. 4 */
 	lcs_ip_mac_addr_pair ip_mac_pair[MAX_IP_MAC_PAIRS];
 	u32 response_data;
-} lcs_ipm_ctlmsg __attribute__ ((packed));
+} __attribute__ ((packed)) lcs_ipm_ctlmsg;
 typedef struct {
 	lcs_header lcs_base_cmd u8 lan_type;
 	u8 rel_adapter_no;
@@ -393,7 +393,7 @@
 	u16 ip_assists_supported;	/* returned by OSA  */
 	u16 ip_assists_enabled;	/* returned by OSA */
 	u16 version;		/* IP version i.e. 4 */
-} lcs_qipassist_ctlmsg __attribute__ ((packed));
+} __attribute__ ((packed)) lcs_qipassist_ctlmsg;
 
 typedef enum {
 	/* Not supported by LCS */
@@ -425,7 +425,7 @@
 	u32 num_rx_errors_detected;
 	u32 num_rx_discarded_nobuffs_avail;
 	u32 num_rx_packets_too_large;
-} lcs_lanstat_reply __attribute__ ((packed));
+} __attribute__ ((packed)) lcs_lanstat_reply;
 
 /* This buffer sizes are used by MVS so they should be reasonable */
 #define LCS_IOBUFFSIZE     0x5000
diff -Nru linux-2.5.44/include/linux/acpi.h attrib-linux/include/linux/acpi.h
--- linux-2.5.44/include/linux/acpi.h	Fri Oct 18 21:00:42 2002
+++ attrib-linux/include/linux/acpi.h	Mon Oct 21 17:31:31 2002
@@ -90,7 +90,7 @@
 typedef struct {
 	u8			type;
 	u8			length;
-} acpi_table_entry_header __attribute__ ((packed));
+} __attribute__ ((packed)) acpi_table_entry_header;
 
 /* Root System Description Table (RSDT) */
 
@@ -143,7 +143,7 @@
 	u16			polarity:2;
 	u16			trigger:2;
 	u16			reserved:12;
-} acpi_interrupt_flags __attribute__ ((packed));
+} __attribute__ ((packed)) acpi_interrupt_flags;
 
 struct acpi_table_lapic {
 	acpi_table_entry_header	header;
diff -Nru linux-2.5.44/include/linux/sctp.h attrib-linux/include/linux/sctp.h
--- linux-2.5.44/include/linux/sctp.h	Fri Oct 18 21:01:59 2002
+++ attrib-linux/include/linux/sctp.h	Mon Oct 21 17:36:35 2002
@@ -59,14 +59,14 @@
 	__u16 dest;
 	__u32 vtag;
 	__u32 checksum;
-} sctp_sctphdr_t __attribute__((packed));
+} __attribute__((packed)) sctp_sctphdr_t;
 
 /* Section 3.2.  Chunk Field Descriptions. */
 typedef struct sctp_chunkhdr {
 	__u8 type;
 	__u8 flags;
 	__u16 length;
-} sctp_chunkhdr_t __attribute__((packed));
+} __attribute__((packed)) sctp_chunkhdr_t;
 
 
 /* Section 3.2.  Chunk Type Values.
@@ -150,7 +150,7 @@
 typedef struct sctp_paramhdr {
 	__u16 type;
 	__u16 length;
-} sctp_paramhdr_t __attribute((packed));
+} __attribute((packed)) sctp_paramhdr_t; 
 
 typedef enum {
 
@@ -200,12 +200,12 @@
 	__u16 ssn;
 	__u32 ppid;
 	__u8  payload[0];
-} sctp_datahdr_t __attribute__((packed));
+} __attribute__((packed)) sctp_datahdr_t;
 
 typedef struct sctp_data_chunk {
         sctp_chunkhdr_t chunk_hdr;
         sctp_datahdr_t  data_hdr;
-} sctp_data_chunk_t __attribute__((packed));
+} __attribute__((packed)) sctp_data_chunk_t;
 
 /* DATA Chuck Specific Flags */
 enum {
@@ -230,48 +230,48 @@
 	__u16 num_inbound_streams;
 	__u32 initial_tsn;
 	__u8  params[0];
-} sctp_inithdr_t __attribute__((packed));
+} __attribute__((packed)) sctp_inithdr_t;
 
 typedef struct sctp_init_chunk {
 	sctp_chunkhdr_t chunk_hdr;
 	sctp_inithdr_t init_hdr;
-} sctp_init_chunk_t __attribute__((packed));
+} __attribute__((packed)) sctp_init_chunk_t;
 
 
 /* Section 3.3.2.1. IPv4 Address Parameter (5) */
 typedef struct sctp_ipv4addr_param {
 	sctp_paramhdr_t param_hdr;
 	struct in_addr  addr;
-} sctp_ipv4addr_param_t __attribute__((packed));
+} __attribute__((packed)) sctp_ipv4addr_param_t;
 
 /* Section 3.3.2.1. IPv6 Address Parameter (6) */
 typedef struct sctp_ipv6addr_param {
 	sctp_paramhdr_t param_hdr;
 	struct in6_addr addr;
-} sctp_ipv6addr_param_t __attribute__((packed));
+} __attribute__((packed)) sctp_ipv6addr_param_t;
 	
 /* Section 3.3.2.1 Cookie Preservative (9) */
 typedef struct sctp_cookie_preserve_param {
 	sctp_paramhdr_t param_hdr;
 	uint32_t        lifespan_increment;
-} sctp_cookie_preserve_param_t __attribute__((packed));
+} __attribute__((packed)) sctp_cookie_preserve_param_t;
 
 /* Section 3.3.2.1 Host Name Address (11) */
 typedef struct sctp_hostname_param {
 	sctp_paramhdr_t param_hdr;
 	uint8_t hostname[0];
-} sctp_hostname_param_t __attribute__((packed));
+} __attribute__((packed)) sctp_hostname_param_t;
 
 /* Section 3.3.2.1 Supported Address Types (12) */
 typedef struct sctp_supported_addrs_param {
 	sctp_paramhdr_t param_hdr;
 	uint16_t types[0];
-} sctp_supported_addrs_param_t __attribute__((packed));
+} __attribute__((packed)) sctp_supported_addrs_param_t;
 
 /* Appendix A. ECN Capable (32768) */
 typedef struct sctp_ecn_capable_param {
 	sctp_paramhdr_t param_hdr;
-} sctp_ecn_capable_param_t __attribute__((packed));
+} __attribute__((packed)) sctp_ecn_capable_param_t;
 
 
 
@@ -285,13 +285,13 @@
 typedef struct sctp_cookie_param {
 	sctp_paramhdr_t p;
 	__u8 body[0];
-} sctp_cookie_param_t __attribute__((packed));
+} __attribute__((packed)) sctp_cookie_param_t;
 
 /* Section 3.3.3.1 Unrecognized Parameters (8) */
 typedef struct sctp_unrecognized_param {
 	sctp_paramhdr_t param_hdr;
 	sctp_paramhdr_t unrecognized;
-} sctp_unrecognized_param_t __attribute__((packed));
+} __attribute__((packed)) sctp_unrecognized_param_t;
 
 
 
@@ -306,7 +306,7 @@
 typedef struct sctp_gap_ack_block {
 	__u16 start;
 	__u16 end;
-} sctp_gap_ack_block_t __attribute__((packed));
+} __attribute__((packed)) sctp_gap_ack_block_t;
 
 typedef uint32_t sctp_dup_tsn_t;
 
@@ -321,12 +321,12 @@
 	__u16 num_gap_ack_blocks;
 	__u16 num_dup_tsns;
 	sctp_sack_variable_t variable[0];
-} sctp_sackhdr_t __attribute__((packed));
+} __attribute__((packed)) sctp_sackhdr_t;
 
 typedef struct sctp_sack_chunk {
 	sctp_chunkhdr_t chunk_hdr;
 	sctp_sackhdr_t sack_hdr;
-} sctp_sack_chunk_t __attribute__((packed));
+} __attribute__((packed)) sctp_sack_chunk_t;
 
 
 /* RFC 2960.  Section 3.3.5 Heartbeat Request (HEARTBEAT) (4):
@@ -338,12 +338,12 @@
 
 typedef struct sctp_heartbeathdr {
 	sctp_paramhdr_t info;
-} sctp_heartbeathdr_t __attribute__((packed));
+} __attribute__((packed)) sctp_heartbeathdr_t; 
 
 typedef struct sctp_heartbeat_chunk {
 	sctp_chunkhdr_t chunk_hdr;
 	sctp_heartbeathdr_t hb_hdr;
-} sctp_heartbeat_chunk_t __attribute__((packed));
+} __attribute__((packed)) sctp_heartbeat_chunk_t;
 	
   
 /* For the abort and shutdown ACK we must carry the init tag in the
@@ -352,7 +352,7 @@
  */
 typedef struct sctp_abort_chunk {
         sctp_chunkhdr_t uh;
-} sctp_abort_chunkt_t __attribute__((packed));
+} __attribute__((packed)) sctp_abort_chunkt_t; 
 
 
 /* For the graceful shutdown we must carry the tag (in common header)
@@ -360,7 +360,7 @@
  */
 typedef struct sctp_shutdownhdr {
 	__u32 cum_tsn_ack;
-} sctp_shutdownhdr_t __attribute__((packed));
+} __attribute__((packed)) sctp_shutdownhdr_t;
 
 struct sctp_shutdown_chunk_t {
         sctp_chunkhdr_t    chunk_hdr;
@@ -375,12 +375,12 @@
 	__u16 cause;
 	__u16 length;
 	__u8  variable[0];
-} sctp_errhdr_t __attribute__((packed));
+} __attribute__((packed)) sctp_errhdr_t;
 
 typedef struct sctp_operr_chunk {
         sctp_chunkhdr_t chunk_hdr;
 	sctp_errhdr_t   err_hdr;
-} sctp_operr_chunk_t __attribute__((packed));
+} __attribute__((packed)) sctp_operr_chunk_t;
 
 /* RFC 2960 3.3.10 - Operation Error
  *
@@ -455,7 +455,7 @@
 typedef struct sctp_ecne_chunk {
 	sctp_chunkhdr_t chunk_hdr;
 	sctp_ecnehdr_t ence_hdr;
-} sctp_ecne_chunk_t __attribute__((packed));
+} __attribute__((packed)) sctp_ecne_chunk_t;
 
 /* RFC 2960.  Appendix A.  Explicit Congestion Notification. 
  *   Congestion Window Reduced (CWR) (13)
@@ -467,7 +467,7 @@
 typedef struct sctp_cwr_chunk {
 	sctp_chunkhdr_t chunk_hdr;
 	sctp_cwrhdr_t cwr_hdr;
-} sctp_cwr_chunk_t __attribute__((packed));
+} __attribute__((packed)) sctp_cwr_chunk_t;
 
 
 /* FIXME:  Cleanup needs to continue below this line. */
diff -Nru linux-2.5.44/include/net/sctp/structs.h attrib-linux/include/net/sctp/structs.h
--- linux-2.5.44/include/net/sctp/structs.h	Fri Oct 18 21:02:34 2002
+++ attrib-linux/include/net/sctp/structs.h	Mon Oct 21 17:37:46 2002
@@ -391,7 +391,7 @@
 	sctp_paramhdr_t param_hdr;
 	sockaddr_storage_t daddr;
 	unsigned long sent_at;
-} sctp_sender_hb_info_t __attribute__((packed));
+} __attribute__((packed)) sctp_sender_hb_info_t;
 
 /* RFC2960 1.4 Key Terms
  *

